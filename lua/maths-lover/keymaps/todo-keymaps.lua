local M = {}

M.mappings = {
  {
    mode = 'n',
    key_trigger = ']t',
    action = function(todo_keywords)
      require('todo-comments').jump_next { keywords = todo_keywords }
    end,
    opts = { desc = 'Next error/warning/todo/fix comment' },
  },

  {
    mode = 'n',
    key_trigger = '[t',
    action = function(todo_keywords)
      require('todo-comments').jump_prev { keywords = todo_keywords }
    end,
    opts = { desc = 'Next error/warning/todo/fix comment' },
  },
}

return M
