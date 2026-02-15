return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '-', '<cmd>Oil<CR>', desc = 'Open parent directory (oil)' },
  },
  opts = {
    columns = { 'icon' },
    delete_to_trash = true,
    view_options = {
      show_hidden = false,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
