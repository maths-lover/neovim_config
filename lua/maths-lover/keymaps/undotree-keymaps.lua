local M = {}

M.mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>u',
    action = function()
      vim.api.nvim_command 'UndotreeToggle'
    end,
    opts = { desc = 'Toggle undotree' },
  },
}

return M
