local pomodoro = require 'pomodoro'

local M = {}

M.mappings = {
  {
    mode = { 'n', 'v' },
    key_trigger = '<leader>ps',
    action = function()
      pomodoro.start()
    end,
    opts = { noremap = true, silent = true, desc = 'Start Pomodoro' },
  },
  {
    mode = { 'n', 'v' },
    key_trigger = '<leader>pp',
    action = function()
      pomodoro.stop()
    end,
    opts = { noremap = true, silent = true, desc = 'Stop Pomodoro' },
  },
  {
    mode = { 'n', 'v' },
    key_trigger = '<leader>pt',
    action = function()
      pomodoro.toggle()
    end,
    opts = { noremap = true, silent = true, desc = 'Toggle Pomodoro' },
  },
  {
    mode = { 'n', 'v' },
    key_trigger = '<leader>p?',
    action = function()
      pomodoro.show_status()
    end,
    opts = { noremap = true, silent = true, desc = 'Show Pomodoro Status' },
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
