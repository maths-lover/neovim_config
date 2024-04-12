local M = {}

M.results_mappings = function(state)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify

  local mappings = {
    e = { val = modify(filename, ':e'), msg = 'Extension only' },
    f = { val = filename, msg = 'Filename' },
    F = { val = modify(filename, ':r'), msg = 'Filename w/o extension' },
    h = { val = modify(filepath, ':~'), msg = 'Path relative to Home' },
    p = { val = modify(filepath, ':.'), msg = 'Path relative to CWD' },
    P = { val = filepath, msg = 'Absolute path' },
  }

  return mappings
end

M.window_mappings = {
  ['<space>'] = false, -- disable space until we figure out which-key disabling
  ['[b'] = 'prev_source',
  [']b'] = 'next_source',
  o = 'open',
  h = 'parent_or_close',
  l = 'child_or_open',
  Y = 'copy_selector',
}

M.main_mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>e',
    action = ':Neotree toggle<CR>',
    opts = { desc = 'Toggle NeoTree' },
  },
}

return M
