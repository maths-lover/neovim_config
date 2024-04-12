return {
  'mbbill/undotree',

  config = function()
    local undotree_mappings = require('maths-lover.keymaps.undotree-keymaps').mappings
    for _, mapping in ipairs(undotree_mappings) do
      vim.keymap.set(mapping.mode, mapping.key_trigger, mapping.action, mapping.opts)
    end
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffAutoOpen = 1
  end,
}
