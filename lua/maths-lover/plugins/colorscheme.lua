return {
  -- Primary: rose-pine
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },

  {
    dir = '~/Develop/projects/pinot_noir.nvim',
    lazy = true,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
  },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'shaunsingh/nord.nvim', lazy = true },
}

-- vim: ts=2 sts=2 sw=2 et
