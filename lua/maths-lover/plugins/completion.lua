return {
  {
    'saghen/blink.cmp',
    version = 'v0.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      keymap = { preset = 'default' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = true },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
