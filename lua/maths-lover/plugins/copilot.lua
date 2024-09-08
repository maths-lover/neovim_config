-- copilot plugin
return {
  'zbirenbaum/copilot.lua',
  enabled = false,
  cmd = 'Copilot',
  build = ':Copilot auth',
  opts = function()
    local mappings = require 'maths-lover.keymaps.copilot-keymaps'
    return {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = mappings.suggestion_maps,
      },
      -- panel is the separate window that shows the suggestions
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = mappings.panel_maps,
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
        ['*'] = true,
      },
    }
  end,
}
