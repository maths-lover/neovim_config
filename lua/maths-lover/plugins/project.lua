return {
  'ahmedkhalf/project.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('project_nvim').setup {
      -- Detect a project root by LSP first, then by these marker files/dirs.
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'go.mod', 'pyproject.toml', 'Cargo.toml', '.root' },

      -- When you open a file, cd to its project root automatically. This is what
      -- lets several projects coexist in one session: telescope's <leader>sf /
      -- <leader>sg always scope to whichever project the active buffer belongs to.
      manual_mode = false,
      scope_chdir = 'global',
      silent_chdir = true,

      -- Don't try to set a root inside these dirs.
      exclude_dirs = { '~/.cargo/*', '~/.local/*' },
      show_hidden = false,
    }

    -- telescope.nvim loads on VimEnter, so it is ready by the time this runs.
    pcall(require('telescope').load_extension, 'projects')

    vim.keymap.set('n', '<leader>fp', function()
      require('telescope').extensions.projects.projects {}
    end, { desc = 'Find project (switch root)' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
