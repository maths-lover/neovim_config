-- Configure Go LSP (gopls) at init time.
-- Base config (cmd, filetypes, root_markers) is loaded from nvim-lspconfig's
-- lsp/gopls.lua; we only need to merge blink.cmp capabilities.

vim.lsp.config('gopls', {
  before_init = function(params)
    local ok, blink = pcall(require, 'blink.cmp')
    if ok then
      params.capabilities = vim.tbl_deep_extend('force', params.capabilities or {}, blink.get_lsp_capabilities())
    end
  end,
})

vim.lsp.enable('gopls')

return {}

-- vim: ts=2 sts=2 sw=2 et
