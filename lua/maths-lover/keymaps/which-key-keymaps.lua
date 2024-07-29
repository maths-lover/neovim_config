local M = {}

M.which_key_mappings = {
  { '<leader>c', group = '[C]omments' },
  { '<leader>c_', hidden = true },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>d_', hidden = true },
  { '<leader>g', group = '[G]eneral actions' },
  { '<leader>g_', hidden = true },
  { '<leader>h', group = 'Git [H]unk actions' },
  { '<leader>h_', hidden = true },
  { '<leader>l', group = '[L]SP actions' },
  { '<leader>l_', hidden = true },
  { '<leader>r', group = '[R]ename' },
  { '<leader>r_', hidden = true },
  { '<leader>s', group = '[S]earch' },
  { '<leader>sG', group = 'Search [G]it' },
  { '<leader>sG_', hidden = true },
  { '<leader>s_', hidden = true },
  { '<leader>t', group = '[T]rouble' },
  { '<leader>t_', hidden = true },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>w_', hidden = true },
}

return M
