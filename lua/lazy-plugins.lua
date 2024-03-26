-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  -- utilize treesitter to auto-comment stuff using nice shortcuts like <leader>cl (comment line)
  require 'plugins.comment',

  -- colorschemes to use
  require 'plugins.colorschemes',

  -- to use git signs, tells useful info about what text is added and what is not
  require 'plugins.gitsigns',

  -- to show keymaps
  require 'plugins.which-key',

  -- to use telescope to find files, words, etc.
  require 'plugins.telescope',

  -- to use LSP
  require 'plugins.lspconfig',

  -- to autoformat code
  require 'plugins.conform',

  -- completion plugin
  require 'plugins.cmp',

  -- highlight TODO, NOTE, FIXME, etc
  require 'plugins.todo-comments',

  -- nice little plugins
  require 'plugins.mini',

  -- well treesitter, the nice coloring, the parser generator for lots of neovim plugins
  require 'plugins.treesitter',

  -- Utlizes dap for debugging
  require 'plugins.debug',

  -- to show indent lines, looks nice to show what scope are we in
  require 'plugins.indent_line',

  -- to automatically lint stuff
  require 'plugins.lint',

  -- startup-dashboard
  require 'plugins.alpha-nvim',

  -- Nice looking UI
  require 'plugins.noice',

  -- status bar  at the bottom
  require 'plugins.lualine',

  -- diagnostic pane like in IDEs
  require 'plugins.trouble',

  -- zen-mode
  'folke/zen-mode.nvim',

  -- github's copilot
  'github/copilot.vim',

  -- useless thing
  'eandrju/cellular-automaton.nvim',

  -- undo tree
  require 'plugins.undotree',

  -- neo-tree for file explorer tree
  require 'plugins.neo-tree',

  -- lspkind to show icons in completion menu
  require 'plugins.lspkind',

  -- toggleterm to toggle a terminal window in neovim session itself
  require 'plugins.toggleterm',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
