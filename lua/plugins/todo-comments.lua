-- todo-keymaps
local function todo_keymaps()
  -- keywords to respond to while navigating todos
  local todo_keywords = { 'NOTE', 'ERROR', 'WARNING', 'TODO', 'FIX', 'FIXME' }

  vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next { keywords = todo_keywords }
  end, { desc = 'Next error/warning/todo/fix comment' })

  vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev { keywords = todo_keywords }
  end, { desc = 'Next error/warning/todo/fix comment' })
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
