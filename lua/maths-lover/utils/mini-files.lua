local MiniFiles = require 'mini.files'

local mappings = require 'maths-lover.keymaps.mini-files-keymaps'

-- Some utility functions {{

-- Split open selected file {{
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
      vim.cmd(direction .. ' split')
      new_target_window = vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target_window)
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end
-- }}

-- Toggle Hidden files {{
local show_dotfiles = true

local filter_show = function(fs_entry)
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, '.')
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh { content = { filter = new_filter } }
end
-- }}
-- Set current working directory to a different directory{{
local files_set_cwd = function(path)
  -- Works only if cursor is on the valid file system entry
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  vim.fn.chdir(cur_directory)
end
-- }}

local function_mappings = {
  split_mappings = map_split,
  toggle_dotfiles = toggle_dotfiles,
  set_cwd = files_set_cwd,
}
-- }}

-- Create autocmds {{

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking

    for _, mapping in ipairs(mappings.split_mappings) do
      map_split(buf_id, mapping.key_trigger, mapping.direction)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    for _, mapping in ipairs(mappings.general_mappings) do
      local opts = mapping.opts or {}
      opts.buffer = buf_id
      vim.keymap.set(mapping.mode, mapping.key_trigger, function_mappings[mapping.action], opts)
    end
  end,
})

-- }}

-- set key mappings now
for _, mapping in ipairs(mappings.when_closed_mappings) do
  vim.keymap.set(mapping.mode, mapping.key_trigger, mapping.action, mapping.opts or {})
end
