local function set_theme(mode)
  if mode == 'light' then
    vim.o.background = 'light'
    vim.cmd.colorscheme 'flexoki-light'
  else
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'rose-pine'
  end
end

local function toggle_theme()
  set_theme(vim.o.background == 'dark' and 'light' or 'dark')
end

return {
  -- Primary light: flexoki
  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    lazy = false,
    priority = 1000,
    config = function()
      set_theme 'light'
    end,
    keys = {
      { '<leader>tt', toggle_theme, desc = 'Toggle light/dark theme' },
    },
  },

  -- Dark companion: rose-pine (eager so the toggle can switch instantly)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 999,
  },

  {
    dir = '~/Develop/projects/pinot_noir.nvim',
    lazy = true,
    dependencies = { 'tjdevries/colorbuddy.nvim' },
  },
  { 'mellow-theme/mellow.nvim', lazy = true },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  { 'shaunsingh/nord.nvim', lazy = true },
}

-- vim: ts=2 sts=2 sw=2 et
