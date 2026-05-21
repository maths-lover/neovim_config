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
    opts = {
      -- The default `muted` Comment fg disappears against the CursorLine
      -- highlight in the dawn variant. `subtle` keeps comments softer than
      -- code while staying readable on highlighted backgrounds.
      --
      -- italic = false on Comment because ComicCode's italic face is a thin
      -- weight that perceptually fades on light bg even at the right color.
      styles = { italic = false },
      highlight_groups = {
        Comment = { fg = 'subtle', italic = false },
        ['@comment'] = { fg = 'subtle', italic = false },
        LineNr = { fg = 'subtle' },
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      set_theme 'light'
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
