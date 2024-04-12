return {
  'numToStr/Comment.nvim',
  opts = function()
    local mappings = require 'maths-lover.keymaps.comment-keymaps'
    return {
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = false,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = mappings.toggle_maps,
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = mappings.opleader_maps,
      ---LHS of extra mappings
      extra = mappings.extra_maps,
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        -- NOTE: Operator-pending mapping; `<leader>cc` `<leader>bc` `<leader>c[count]{motion}` `<leader>b[count]{motion}`
        basic = true,
        -- NOTE: Extra mapping; `<leader>co`, `<leader>cO`, `<leader>cA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = nil,
    }
  end,
  lazy = false,
}
