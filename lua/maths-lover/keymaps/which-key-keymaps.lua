local M = {}

M.register_key_mappings = {
  ['<leader>c'] = { name = '[C]omments', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP actions', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]rouble', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>sG'] = { name = 'Search [G]it', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]eneral actions', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk actions', _ = 'which_key_ignore' },
}

return M
