return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    { '<leader>cd', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>cD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
    {
      ']d',
      function()
        require('trouble').next { mode = 'diagnostics', jump = true }
      end,
      desc = 'Next diagnostic',
    },
    {
      '[d',
      function()
        require('trouble').prev { mode = 'diagnostics', jump = true }
      end,
      desc = 'Previous diagnostic',
    },
    {
      ']e',
      function()
        require('trouble').next { mode = 'diagnostics', jump = true, filter = { severity = vim.diagnostic.severity.ERROR } }
      end,
      desc = 'Next error',
    },
    {
      '[e',
      function()
        require('trouble').prev { mode = 'diagnostics', jump = true, filter = { severity = vim.diagnostic.severity.ERROR } }
      end,
      desc = 'Previous error',
    },
    {
      ']w',
      function()
        require('trouble').next { mode = 'diagnostics', jump = true, filter = { severity = vim.diagnostic.severity.WARN } }
      end,
      desc = 'Next warning',
    },
    {
      '[w',
      function()
        require('trouble').prev { mode = 'diagnostics', jump = true, filter = { severity = vim.diagnostic.severity.WARN } }
      end,
      desc = 'Previous warning',
    },
  },
  opts = {
    focus = true,
  },
}

-- vim: ts=2 sts=2 sw=2 et
