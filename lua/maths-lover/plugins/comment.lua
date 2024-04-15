return {
  'numToStr/Comment.nvim',
  opts = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = false,
    ---Lines to be ignored while (un)comment
    ignore = nil,

    ---Enable keybindings
    -- NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      basic = true,
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
  },
  config = function(_, opts)
    local mappings = require 'maths-lover.keymaps.comment-keymaps'
    ---LHS of toggle mappings in NORMAL mode
    opts.toggler = mappings.toggle_maps
    -- set the opleader so instead of gc.* it starts with what we want
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opts.opleader = mappings.opleader_maps
    ---LHS of extra mappings
    opts.extra = mappings.extra_maps

    -- Setup opts
    require('Comment').setup(opts)
  end,
  lazy = false,
}
