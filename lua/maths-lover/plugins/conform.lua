return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { bufnr = vim.api.nvim_get_current_buf() }
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      dart = { 'dart_format' },
      lua = { 'stylua' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
