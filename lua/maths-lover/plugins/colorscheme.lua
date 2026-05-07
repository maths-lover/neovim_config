local function set_theme(mode)
  if mode == 'light' then
    vim.o.background = 'light'
    vim.cmd.colorscheme 'rose-pine-dawn'
  else
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'rose-pine-main'
  end
end

local function toggle_theme()
  set_theme(vim.o.background == 'dark' and 'light' or 'dark')
end

return {
  -- Primary light: lunaperche
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      set_theme 'dark'
    end,
    keys = {
      { '<leader>tt', toggle_theme, desc = 'Toggle light/dark theme' },
    },
  },

  {
    dir = '~/Develop/projects/pinot_noir.nvim',
    lazy = true,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
  },
  { 'shaunsingh/nord.nvim', lazy = true },
}

-- vim: ts=2 sts=2 sw=2 et
