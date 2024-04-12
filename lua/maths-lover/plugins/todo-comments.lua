-- todo-keymaps
local function todo_keymaps()
  -- keywords to respond to while navigating todos
  local todo_keywords = { 'NOTE', 'ERROR', 'WARNING', 'TODO', 'FIX', 'FIXME' }
  local map = function(mode, key_trigger, action, opts)
    opts = opts or {}
    vim.keymap.set(mode, key_trigger, function()
      action(todo_keywords)
    end, opts)
  end
  for _, mapping in ipairs(require('maths-lover.keymaps.todo-keymaps').mappings) do
    map(mapping.mode, mapping.key_trigger, mapping.action, mapping.opts)
  end
end

-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = true,
    },
    init = function()
      todo_keymaps()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
