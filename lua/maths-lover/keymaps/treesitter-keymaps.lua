local M = {}

M.textobjects_mappings = {
  ['ak'] = { query = '@block.outer', desc = 'around block' },
  ['ik'] = { query = '@block.inner', desc = 'inside block' },
  ['ac'] = { query = '@class.outer', desc = 'around class' },
  ['ic'] = { query = '@class.inner', desc = 'inside class' },
  ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
  ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
  ['af'] = { query = '@function.outer', desc = 'around function ' },
  ['if'] = { query = '@function.inner', desc = 'inside function ' },
  ['al'] = { query = '@loop.outer', desc = 'around loop' },
  ['il'] = { query = '@loop.inner', desc = 'inside loop' },
  ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
  ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
}

-- Using default mappings for incremental selection
M.incremental_selection_mappings = {
  -- init_selection: in normal mode, start incremental selection.
  init_selection = 'gnn',

  -- node_incremental: in visual mode, increment to the upper named parent.
  node_incremental = 'grn',

  -- scope_incremental: in visual mode, increment to the upper scope
  scope_incremental = 'grc',

  -- node_decremental: in visual mode, decrement to the previous named node.
  node_decremental = 'grm',
}

M.move_mappings = {
  goto_next_start_mappings = {
    [']k'] = { query = '@block.outer', desc = 'Next block start' },
    [']f'] = { query = '@function.outer', desc = 'Next function start' },
    [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
  },
  goto_next_end_mappings = {
    [']K'] = { query = '@block.outer', desc = 'Next block end' },
    [']F'] = { query = '@function.outer', desc = 'Next function end' },
    [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
  },
  goto_previous_start_mappings = {
    ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
    ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
    ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
  },
  goto_previous_end_mappings = {
    ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
    ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
    ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
  },
}

M.swap_mappings = {
  swap_next_mappings = {
    ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
    ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
    ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
  },
  swap_previous_mappings = {
    ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
    ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
    ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
  },
}

return M

-- vim: ts=2 sts=2 sw=2 et
