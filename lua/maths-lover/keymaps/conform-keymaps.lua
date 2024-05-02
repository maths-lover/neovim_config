local conform = require 'conform'

vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  }
end, { desc = 'Manually format the code' })
