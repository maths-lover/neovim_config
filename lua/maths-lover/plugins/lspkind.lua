return {
  'onsails/lspkind-nvim',
  config = function()
    local opts = {
      mode = 'symbol',
      symbol_map = {
        NONE = '',
        Array = '',
        Boolean = '',
        Class = '',
        Constructor = '',
        Key = '',
        Namespace = '',
        Null = '󰟢',
        Number = '',
        Object = '',
        Package = '',
        Property = '',
        Reference = '',
        Snippet = '',
        String = '',
        TypeParameter = '',
        Unit = '',
      },
    }

    require('lspkind').init(opts)
  end,
}
