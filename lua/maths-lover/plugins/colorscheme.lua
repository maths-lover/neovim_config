return {
  -- Primary: modern noir theme (local plugin)
  {
    dir = '~/Develop/projects/pinot_noir.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    config = function()
      vim.cmd.colorscheme 'pinot_noir'
    end,
  },

  { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'shaunsingh/nord.nvim', lazy = true },
}

-- vim: ts=2 sts=2 sw=2 et
