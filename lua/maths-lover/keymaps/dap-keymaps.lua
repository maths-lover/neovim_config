-- local dap = require 'dap'
-- local dapui = require 'dapui'
local dap = package.loaded.dap
local dapui = package.loaded.dapui

local M = {}

M.mappings = {
  {
    mode = 'n',
    key_trigger = '<F5>',
    action = dap.continue,
    opts = { desc = 'Debug: Start/Continue' },
  },
  {
    mode = 'n',
    key_trigger = '<F1>',
    action = dap.step_into,
    opts = { desc = 'Debug: Step Into' },
  },
  {
    mode = 'n',
    key_trigger = '<F2>',
    action = dap.step_over,
    opts = { desc = 'Debug: Step Over' },
  },
  {
    mode = 'n',
    key_trigger = '<F3>',
    action = dap.step_out,
    opts = { desc = 'Debug: Step out' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>db',
    action = dap.toggle_breakpoint,
    opts = { desc = 'Debug: Toggle Breakpoint' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>dB',
    action = function()
      dap.set_breakpoint(vim.fn.input 'Breakpint condition: ')
    end,
    opts = { desc = 'Debug: Set Breakpoint' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>dc',
    action = dapui.toggle,
    opts = { desc = 'Debug: See last session result.' },
  },
}

return M
