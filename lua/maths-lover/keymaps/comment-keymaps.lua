local M = {}

M.toggle_maps = {
  ---Line-comment toggle keymap
  line = '<leader>clc',
  ---Block-comment toggle keymap
  block = '<leader>cbc',
}

M.opleader_maps = {
  ---Line-comment keymap
  line = '<leader>cl',
  ---Block-comment keymap
  block = '<leader>cb',
}

M.extra_maps = {
  ---Add comment on the line above
  above = '<leader>cO',
  ---Add comment on the line below
  below = '<leader>co',
  ---Add comment at the end of line
  eol = '<leader>cA',
}

return M
