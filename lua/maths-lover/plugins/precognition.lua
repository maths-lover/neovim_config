return {
  'tris203/precognition.nvim',
  opts = {
    startVisible = false,
    -- hints = {
    --     ["^"] = { text = "^", prio = 1 },
    --     ["$"] = { text = "$", prio = 1 },
    --     ["w"] = { text = "w", prio = 10 },
    --     ["b"] = { text = "b", prio = 10 },
    --     ["e"] = { text = "e", prio = 10 },
    -- },
    -- gutterHints = {
    --     --prio is not currentlt used for gutter hints
    --     ["G"] = { text = "G", prio = 1 },
    --     ["gg"] = { text = "gg", prio = 1 },
    --     ["{"] = { text = "{", prio = 1 },
    --     ["}"] = { text = "}", prio = 1 },
    -- },
  },
  init = function()
    local keymaps = require 'maths-lover.keymaps.precognition-keymaps'
    keymaps.map()
  end,
}
