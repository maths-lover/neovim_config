-- This is config part of hrsh7th/nvim-cmp plugin
-- Just separating it out

-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'
local icon = require('maths-lover.utils').get_icon

-- mappings for nvim-cmp
local cmp_custom_mappings = require('maths-lover.keymaps.cmp-keymaps').mappings

local border_opts = {
  border = 'rounded',
  winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
  scrollbar = '║',
}

luasnip.config.setup {}
cmp.setup {
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text', -- show symbol with type annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = icon 'Ellipsis', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      with_text = true,
    },
  },
  window = {
    completion = cmp.config.window.bordered(border_opts),
    documentation = cmp.config.window.bordered(border_opts),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noselect' },
  mapping = cmp.mapping.preset.insert(cmp_custom_mappings),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'cody' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
