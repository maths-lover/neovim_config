local gs = package.loaded.gitsigns

local M = {}

M.navigation_maps = {
  {
    mode = 'n',
    key_trigger = ']c',
    action = function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end,
    opts = { expr = true, desc = 'Next hunk' },
  },
  {
    mode = 'n',
    key_trigger = '[c',
    action = function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end,
    opts = { expr = true, desc = 'Previous hunk' },
  },
}

M.action_mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>hs',
    action = gs.stage_hunk,
    opts = { desc = 'Stage Hunk' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hr',
    action = gs.reset_hunk,
    opts = { desc = 'Reset Hunk' },
  },
  {
    mode = 'v',
    key_trigger = '<leader>hs',
    action = function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end,
    opts = { desc = 'Stage selected hunk only' },
  },
  {
    mode = 'v',
    key_trigger = '<leader>hr',
    action = function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end,
    opts = { desc = 'Reset selected hunk only' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hS',
    action = gs.stage_buffer,
    opts = { desc = 'Stage Buffer' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hu',
    action = gs.undo_stage_hunk,
    opts = { desc = 'Undo Stage Hunk' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hR',
    action = gs.reset_buffer,
    opts = { desc = 'Reset Buffer hunk' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hp',
    action = gs.preview_hunk,
    opts = { desc = 'Preview Hunk' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hb',
    action = function()
      gs.blame_line { full = false }
    end,
    opts = { desc = 'Blame Line' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>tb',
    action = gs.toggle_current_line_blame,
    opts = { desc = 'Toggle Blame Line' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hd',
    action = gs.diffthis,
    opts = { desc = 'Diff This' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>hD',
    action = function()
      gs.diffthis '~'
    end,
    opts = { desc = 'Diff This (toggle deleted)' },
  },
}

M.textobject_mappings = {
  -- Text object
  {
    mode = { 'o', 'x' },
    key_trigger = 'ih',
    action = ':<C-U>Gitsigns select_hunk<CR>',
    opts = { desc = 'Gitsigns select_hunk' },
  },
}

M.all_mappings = vim.tbl_flatten {
  M.navigation_maps,
  M.action_mappings,
  M.textobject_mappings,
}

return M
