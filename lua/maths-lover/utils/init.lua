local M = {}

function M.get_icon(kind, padding, no_fallback)
  if not vim.g.have_nerd_font and no_fallback then
    return ''
  end
  local icon_pack = vim.g.have_nerd_font and 'icons' or 'text_icons'
  if not M[icon_pack] then
    M.icons = require 'maths-lover.icons.nerd_font'
    M.text_icons = require 'maths-lover.icons.text'
  end
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(' ', padding or 0) or ''
end

function M.set_colorscheme(name)
  -- if name is not provided, use paradise as default
  -- or if it has only spaces, then use paradise as default
  if not name or name:match '^%s*$' then
    name = 'paradise'
  end
  local theme_name = name

  vim.opt.background = 'dark'
  vim.opt.termguicolors = true
  -- vim.cmd.hi 'Comment gui=none' -- used in tokyonight colorscheme

  -- try setting it if it is already present
  local ok, err = pcall(vim.cmd.colorscheme, theme_name)
  if not ok then
    print('1. ' .. err)
    -- now try setting it as base16 colorscheme
    ok, err = pcall(vim.cmd.colorscheme, 'base16-' .. theme_name)
    -- if both fail, then try setting it as base16 but custom colors from the colors directory
    if not ok then
      print('2. ' .. err)
      local base16 = require 'base16-colorscheme'
      local custom_theme
      custom_theme, err = pcall(require, 'maths-lover.colors.' .. theme_name)
      if not custom_theme then
        print('3. No custom colorscheme found for ' .. theme_name .. ' using tokyonight-night')
        vim.cmd.colorscheme 'tokyonight-night' -- default theme
      else
        base16.setup(require('maths-lover.colors.' .. theme_name))
      end
    end
  end
end

return M
