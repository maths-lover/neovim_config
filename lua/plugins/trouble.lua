return {
  'folke/trouble.nvim',
  opts = {
    icons = true,
  },

  config = function(_, opts)
    require('trouble').setup(opts or {})

    -- set keymaps
    local trouble = require 'trouble'
    vim.keymap.set('n', '<leader>tt', function()
      trouble.toggle()
    end, { desc = 'Toggle [T]rouble' })

    vim.keymap.set('n', '<leader>tn', function()
      trouble.next { skip_groups = true, jump = true }
    end, { desc = '[T]rouble [N]ext diagnostic' })

    vim.keymap.set('n', '<leader>tp', function()
      trouble.previous { skip_groups = true, jump = true }
    end, { desc = '[T]rouble [P]revious diagnostic' })
  end,
}
