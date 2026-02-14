return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'ui-select'

      local builtin = require 'telescope.builtin'

      -- Files
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files (fd)' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search buffers' })

      -- Grep
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep (rg)' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search word under cursor' })
      vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find, { desc = 'Search in current buffer' })

      -- Help & meta
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search resume (last picker)' })

      -- Diagnostics & symbols
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = 'Search treesitter symbols' })

      -- Colorscheme
      vim.keymap.set('n', '<leader>sC', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = 'Search colorschemes (preview)' })

      -- Git
      vim.keymap.set('n', '<leader>sc', builtin.git_commits, { desc = 'Search git commits' })
      vim.keymap.set('n', '<leader>ss', builtin.git_status, { desc = 'Search git status' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
