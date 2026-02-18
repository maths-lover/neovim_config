return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function(_, opts)
    require('lualine').setup(opts)
    -- deferred: lualine sets laststatus=2 during setup and may have
    -- scheduled callbacks that re-set it; defer to run after all of them
    vim.defer_fn(function()
      vim.o.laststatus = 0
    end, 50)
  end,
  opts = {
    options = {
      theme = 'auto',
      component_separators = { left = '│', right = '│' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'diagnostics', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
