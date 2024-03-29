local function set_colorscheme()
  vim.opt.background = 'dark'
  vim.cmd.colorscheme 'evergarden'
  vim.opt.termguicolors = true
  -- vim.cmd.hi 'Comment gui=none' -- used in tokyonight colorscheme
end

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'crispybaccoon/evergarden',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'fenetikm/falcon',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = set_colorscheme,
  },
  {
    'savq/melange-nvim',
    priority = 1000,
    init = set_colorscheme,
  },
}
