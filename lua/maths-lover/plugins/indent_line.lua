return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      scope = { show_start = false, show_end = false },
      indent = {
        char = '┆',
      },
      exclude = {
        buftypes = {
          'nofile',
          'terminal',
        },
        filetypes = {
          'help',
          'startify',
          'aerial',
          'alpha',
          'dashboard',
          'lazy',
          'neogitstatus',
          'NvimTree',
          'neo-tree',
          'Trouble',
        },
      },
    },
  },
}
