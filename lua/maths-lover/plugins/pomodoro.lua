local home_dir = os.getenv 'HOME'
local dev_dir = nil
dev_dir = os.getenv 'DEV_DIR'
if not dev_dir then
  dev_dir = home_dir .. '/projects'
end
local plugins_dir = dev_dir .. '/personal_projects'

return {
  -- dir = plugins_dir .. '/pomodoro.nvim',
  'maths-lover/pomodoro.nvim',
  opts = {
    autostart = true,
    icon_path = '/usr/local/share/icons/hicolor/128x128/apps/nvim.png',
  },
  init = function()
    local keymaps = require 'maths-lover.keymaps.pomodoro-keymaps'
    keymaps.map()
  end,
}
