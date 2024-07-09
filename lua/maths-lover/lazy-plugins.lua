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
  require 'maths-lover.plugins.comment',

  -- colorschemes to use
  require 'maths-lover.plugins.colorschemes',

  -- to use git signs, tells useful info about what text is added and what is not
  require 'maths-lover.plugins.gitsigns',

  -- to show keymaps
  require 'maths-lover.plugins.which-key',

  -- to use telescope to find files, words, etc.
  require 'maths-lover.plugins.telescope',

  -- to use LSP
  require 'maths-lover.plugins.lspconfig',

  -- to use LSP but for typescript projects
  require 'maths-lover.plugins.typescript-tools',

  -- to autoformat code
  require 'maths-lover.plugins.conform',

  -- completion plugin
  require 'maths-lover.plugins.cmp',

  -- highlight TODO, NOTE, FIXME, etc
  require 'maths-lover.plugins.todo-comments',

  -- nice little plugins
  require 'maths-lover.plugins.mini',

  -- well treesitter, the nice coloring, the parser generator for lots of neovim maths-lover.plugins
  require 'maths-lover.plugins.treesitter',

  -- Utlizes dap for debugging
  require 'maths-lover.plugins.debug',

  -- to show indent lines, looks nice to show what scope are we in
  -- require 'maths-lover.plugins.indent_line',

  -- to automatically lint stuff
  require 'maths-lover.plugins.lint',

  -- startup-dashboard
  -- require 'maths-lover.plugins.alpha-nvim',

  -- Nice looking UI
  require 'maths-lover.plugins.noice',

  -- status bar  at the bottom
  require 'maths-lover.plugins.lualine',

  -- diagnostic pane like in IDEs
  require 'maths-lover.plugins.trouble',

  -- github's copilot
  require 'maths-lover.plugins.copilot',

  -- undo tree
  require 'maths-lover.plugins.undotree',

  -- neo-tree for file explorer tree --  bye bye!
  -- require 'maths-lover.plugins.neo-tree',

  -- lspkind to show icons in completion menu
  require 'maths-lover.plugins.lspkind',

  -- toggleterm to toggle a terminal window in neovim session itself
  require 'maths-lover.plugins.toggleterm',

  -- lsp-lens to show references, definitions, etc
  require 'maths-lover.plugins.lsp-lens',

  -- precognition for quick movements
  require 'maths-lover.plugins.precognition',
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
