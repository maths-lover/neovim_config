return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    delay = 300,
    icons = {
      mappings = vim.g.have_nerd_font,
    },
    spec = {
      { '<leader>s', group = 'Search' },
      { '<leader>c', group = 'Code' },
      { '<leader>t', group = 'Tabs' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = true }
      end,
      desc = 'Show all keymaps (which-key)',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
