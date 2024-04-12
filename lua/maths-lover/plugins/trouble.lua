return {
  'folke/trouble.nvim',
  opts = {
    icons = true,
  },

  config = function(_, opts)
    require('trouble').setup(opts or {})

    -- set keymaps
    local trouble_mappings = require('maths-lover.keymaps.trouble-keymaps').mappings
    for _, mapping in ipairs(trouble_mappings) do
      vim.keymap.set(mapping.mode, mapping.key_trigger, mapping.action, mapping.opts or {})
    end
  end,
}
