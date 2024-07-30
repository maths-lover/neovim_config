local pc = require 'precognition'

local M = {}

M.mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>Pt',
    action = function()
      pc.toggle()
    end,
    opts = { desc = 'Toggle Precognition' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>Pp',
    action = function()
      pc.peek()
    end,
    opts = { desc = 'Toggle Precognition' },
  },
}

M.map = function()
  for _, mapping in ipairs(M.mappings) do
    local mode = mapping.mode
    local key_trigger = mapping.key_trigger
    local action = mapping.action
    local opts = mapping.opts

    vim.keymap.set(mode, key_trigger, action, opts)
  end
end

return M
