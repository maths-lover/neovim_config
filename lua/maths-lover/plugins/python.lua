--- Resolve the project's Python interpreter for a given root.
--- Resolution order:
---   1. $VIRTUAL_ENV (an already-activated venv wins)
---   2. <root>/.venv/bin/python (uv default, also `python -m venv .venv`)
---   3. <root>/venv/bin/python  (common alternative)
---   4. pyenv via .python-version → ~/.pyenv/versions/<name>/bin/python
---   5. system python3
---@param start_path string? directory to start from (defaults to cwd)
---@return string python_path absolute path to the python binary
---@return string source short label describing where the path came from
local function resolve_python(start_path)
  local path = start_path or vim.fn.getcwd()

  -- 1. already-activated venv
  local active = vim.env.VIRTUAL_ENV
  if active and active ~= '' then
    local p = active .. '/bin/python'
    if vim.uv.fs_stat(p) then
      return p, 'VIRTUAL_ENV'
    end
  end

  -- 2 & 3. local venv directories — search upward so opening a file deep in
  -- the tree still finds the project venv at the repo root.
  for _, dirname in ipairs { '.venv', 'venv' } do
    local marker = vim.fs.find(dirname, { path = path, upward = true, type = 'directory' })[1]
    if marker then
      local p = marker .. '/bin/python'
      if vim.uv.fs_stat(p) then
        return p, dirname
      end
    end
  end

  -- 4. pyenv .python-version
  local version_file = vim.fs.find('.python-version', { path = path, upward = true, type = 'file' })[1]
  if version_file then
    local lines = vim.fn.readfile(version_file, '', 1)
    if lines and #lines > 0 then
      local venv_name = vim.trim(lines[1])
      if venv_name ~= '' then
        local pyenv_python = vim.fn.expand('~/.pyenv/versions/' .. venv_name .. '/bin/python')
        if vim.uv.fs_stat(pyenv_python) then
          return pyenv_python, 'pyenv'
        end
      end
    end
  end

  -- 5. system fallback
  return vim.fn.exepath 'python3' or 'python3', 'system'
end

-- Configure Python LSP servers at init time.
-- vim.lsp.config() and vim.lsp.enable() are native Neovim 0.11 APIs that
-- register configs eagerly; the actual server start is deferred to FileType
-- events. Calling vim.lsp.enable() here (before VimEnter) ensures its
-- FileType autocmd is registered in time for the first Python buffer.

local function with_blink_caps(params)
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    params.capabilities = vim.tbl_deep_extend('force', params.capabilities or {}, blink.get_lsp_capabilities())
  end
end

-- basedpyright: static type checking, intellisense, go-to-definition
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true, -- read installed packages for types
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  before_init = function(params, config)
    with_blink_caps(params)

    local python_path, source = resolve_python(config.root_dir)
    config.settings = config.settings or {}
    config.settings.python = vim.tbl_deep_extend('force', config.settings.python or {}, {
      pythonPath = python_path,
    })

    -- Stash for the inspection command so the user can verify the pick.
    vim.b._python_interpreter = python_path
    vim.b._python_source = source
  end,
})

-- ruff: linting diagnostics and code actions
-- Formatting disabled here; conform.nvim handles it via ruff_format
vim.lsp.config('ruff', {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  before_init = function(params, config)
    with_blink_caps(params)

    local python_path = resolve_python(config.root_dir)
    config.init_options = vim.tbl_deep_extend('force', config.init_options or {}, {
      settings = {
        interpreter = { python_path },
      },
    })
  end,
})

vim.lsp.enable { 'basedpyright', 'ruff' }

-- :PyInfo prints the interpreter and source the LSPs are using for the
-- current buffer. Handy for debugging when type-checking looks off in a
-- uv/pyenv project.
vim.api.nvim_create_user_command('PyInfo', function()
  local interp = vim.b._python_interpreter
  local source = vim.b._python_source
  if not interp then
    local p, s = resolve_python()
    interp, source = p, s .. ' (no LSP attached yet)'
  end
  vim.notify(string.format('Python: %s\nSource: %s', interp, source), vim.log.levels.INFO)
end, { desc = 'Show resolved Python interpreter for current buffer' })

return {}

-- vim: ts=2 sts=2 sw=2 et
