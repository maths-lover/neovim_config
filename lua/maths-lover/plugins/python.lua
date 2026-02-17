--- Resolve the pyenv virtualenv Python path for a given project root.
--- Walks upward from `start_path` looking for `.python-version`, reads the
--- virtualenv/version name, and resolves to ~/.pyenv/versions/<name>/bin/python.
--- Falls back to system python3 if not found or invalid.
---@param start_path string? directory to start from (defaults to cwd)
---@return string python_path absolute path to the python binary
local function resolve_pyenv_python(start_path)
  local path = start_path or vim.fn.getcwd()

  local version_file = vim.fs.find('.python-version', {
    path = path,
    upward = true,
    type = 'file',
  })[1]

  if version_file then
    local lines = vim.fn.readfile(version_file, '', 1)
    if lines and #lines > 0 then
      local venv_name = vim.trim(lines[1])
      if venv_name ~= '' then
        local pyenv_python = vim.fn.expand('~/.pyenv/versions/' .. venv_name .. '/bin/python')
        if vim.uv.fs_stat(pyenv_python) then
          return pyenv_python
        end
      end
    end
  end

  return vim.fn.exepath 'python3' or 'python3'
end

-- Configure Python LSP servers at init time.
-- vim.lsp.config() and vim.lsp.enable() are native Neovim 0.11 APIs that
-- register configs eagerly; the actual server start is deferred to FileType
-- events. Calling vim.lsp.enable() here (before VimEnter) ensures its
-- FileType autocmd is registered in time for the first Python buffer.
-- Base configs (cmd, filetypes, root_markers) are loaded lazily from
-- nvim-lspconfig's lsp/*.lua files when the config is resolved.

-- basedpyright: static type checking, intellisense, go-to-definition
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  before_init = function(params, config)
    -- Merge blink.cmp capabilities into the initialize request
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      params.capabilities = vim.tbl_deep_extend('force', params.capabilities or {}, blink.get_lsp_capabilities())
    end

    -- Set python path from pyenv virtualenv (mutate in-place so self.settings
    -- also reflects the change for workspace/didChangeConfiguration)
    local python_path = resolve_pyenv_python(config.root_dir)
    config.settings = config.settings or {}
    config.settings.python = vim.tbl_deep_extend('force', config.settings.python or {}, {
      pythonPath = python_path,
    })
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
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      params.capabilities = vim.tbl_deep_extend('force', params.capabilities or {}, blink.get_lsp_capabilities())
    end

    local python_path = resolve_pyenv_python(config.root_dir)
    config.init_options = vim.tbl_deep_extend('force', config.init_options or {}, {
      settings = {
        interpreter = { python_path },
      },
    })
  end,
})

vim.lsp.enable { 'basedpyright', 'ruff' }

return {}

-- vim: ts=2 sts=2 sw=2 et
