return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = {
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Next TODO' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous TODO' },
    { '<leader>sT', '<cmd>TodoTelescope<CR>', desc = 'Search TODOs' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
