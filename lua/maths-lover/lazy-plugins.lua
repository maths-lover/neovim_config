-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

-- NOTE: Here is where you include your plugins.
require('lazy').setup({
  spec = {
    { import = 'maths-lover.plugins' },
    -- add more like above if you have your own set of plugins, like following
    -- { import = 'your_username.plugins' },
  },

  -- colorscheme to use while installing plugins
  install = { colorscheme = { 'nord', 'gruvbuddy', 'habamax' } },

  -- automatically check updates
  checker = { enabled = true, notify = true },
}, {
  -- ui components
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
