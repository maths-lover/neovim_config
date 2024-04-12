local trouble = require 'trouble'
local M = {}

M.mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>tt',
    action = function()
      trouble.toggle()
    end,
    opts = { desc = 'Toggle [T]rouble' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>tn',
    action = function()
      trouble.next { skip_groups = true, jump = true }
    end,
    opts = { desc = '[T]rouble [N]ext diagnostic' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>tp',
    action = function()
      trouble.previous { skip_groups = true, jump = true }
    end,
    opts = { desc = '[T]rouble [P]revious diagnostic' },
  },
}

return M
