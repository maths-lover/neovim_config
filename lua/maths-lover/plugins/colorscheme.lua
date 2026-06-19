-- Kanagawa colorscheme, following the system-wide variant chosen by
-- ~/.local/bin/kanagawa-switch (Super+T). New nvim instances pick up the
-- active variant on startup; open instances follow it on FocusGained.
local active_file = vim.fn.expand '~/.config/themes/kanagawa/active'

local function active_variant()
  local f = io.open(active_file, 'r')
  if not f then
    return 'wave'
  end
  local v = f:read 'l' or 'wave'
  f:close()
  v = (v or ''):gsub('%s+', '')
  if v ~= 'wave' and v ~= 'dragon' and v ~= 'lotus' then
    v = 'wave'
  end
  return v
end

-- Only issue :colorscheme when the variant actually changes. Re-running
-- :colorscheme clears lualine's highlight groups, so an unconditional
-- re-apply on FocusGained would break the statusline right after startup.
local current
local function apply(variant)
  if variant == current then
    return
  end
  current = variant
  vim.o.background = (variant == 'lotus') and 'light' or 'dark'
  vim.cmd.colorscheme('kanagawa-' .. variant)
end

return {
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      dimInactive = false,
      background = { dark = 'wave', light = 'lotus' },
      overrides = function()
        -- ComicCode's italic face fades perceptibly; keep comments upright.
        return {
          Comment = { italic = false },
          ['@comment'] = { italic = false },
        }
      end,
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      apply(active_variant())
      -- follow Super+T (kanagawa-switch) when nvim regains focus
      vim.api.nvim_create_autocmd('FocusGained', {
        callback = function()
          apply(active_variant())
        end,
      })
    end,
    keys = {
      {
        '<leader>tt',
        function()
          -- quick light/dark toggle: lotus <-> wave
          apply(active_variant() == 'lotus' and 'wave' or 'lotus')
        end,
        desc = 'Toggle light/dark (kanagawa)',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
