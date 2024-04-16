local MiniFiles = require 'mini.files'
local M = {}

M.when_closed_mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>f',
    action = function(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end,
    opts = { desc = 'Toggle mini.files for file management' },
  },
}

M.split_mappings = {
  {
    key_trigger = 'S',
    direction = 'belowright horizontal',
  },
  {
    key_trigger = 's',
    direction = 'belowright vertical',
  },
}

M.general_mappings = {
  {
    mode = 'n',
    key_trigger = 'g.',
    action = 'toggle_dotfiles',
    opts = { desc = 'Toggle hidden dot files' },
  },
  {
    mode = 'n',
    key_trigger = 'g~',
    action = 'set_cwd',
    opts = { desc = 'Set current working directory to directory under the cursor' },
  },
}

return M
