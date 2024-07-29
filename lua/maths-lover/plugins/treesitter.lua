return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          max_lines = 5,
          multiline_threshold = 5,
        },
      },
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'regex', 'markdown_inline', 'go', 'python', 'cpp', 'c', 'query' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      autotag = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      highlight = {
        enable = true,
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      incremental_selection = { enable = true },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
        },
        move = {
          enable = true,
          set_jumps = true,
        },
        swap = {
          enable = true,
        },
      },
    },
    config = function(_, opts)
      -- Below are just keymap configuration
      local treesitter_mappings = require 'maths-lover.keymaps.treesitter-keymaps'
      opts.textobjects.select.keymaps = treesitter_mappings.textobjects_mappings
      opts.textobjects.move.goto_next_start = treesitter_mappings.move_mappings.goto_next_start_mappings
      opts.textobjects.move.goto_next_end = treesitter_mappings.move_mappings.goto_next_end_mappings
      opts.textobjects.move.goto_previous_start = treesitter_mappings.move_mappings.goto_previous_start_mappings
      opts.textobjects.move.goto_previous_end = treesitter_mappings.move_mappings.goto_previous_end_mappings
      opts.textobjects.swap.swap_next = treesitter_mappings.swap_mappings.swap_next_mappings
      opts.textobjects.swap.swap_previous = treesitter_mappings.swap_mappings.swap_previous_mappings
      opts.incremental_selection.keymaps = treesitter_mappings.incremental_selection_mappings

      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - (Enabled) Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - (Enabled) Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - (Enabled) Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
