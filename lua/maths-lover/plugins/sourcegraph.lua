return {
  {
    'sourcegraph/sg.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      on_attach = function()
        local bind_module = require 'maths-lover.keymaps.sourcegraph-keymaps'
        bind_module.set_bindings()
      end,
      accept_tos = true,
    },
  },
}
