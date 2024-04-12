return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = function()
    local terminal_mappings = require('maths-lover.keymaps.toggleterm-keymaps').mappings
    return {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = terminal_mappings.open_mapping,
      shading_factor = 2,
      direction = 'float',
      float_opts = {
        border = 'curved',
        highlights = { border = 'Normal', background = 'Normal' },
      },
    }
  end,
}
