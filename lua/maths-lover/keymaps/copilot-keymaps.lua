local M = {}

M.suggestion_maps = {
  accept = '<tab>',
  accept_word = false,
  accept_line = false,
  next = '<M-]>',
  prev = '<M-[>',
  dismiss = '<C-]>',
}

M.panel_maps = {
  jump_prev = '[[',
  jump_next = ']]',
  accept = '<CR>',
  refresh = 'gr',
  open = '<M-CR>',
}

return M
