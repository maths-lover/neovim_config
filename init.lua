-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'maths-lover.options'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'maths-lover.lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'maths-lover.lazy-plugins'

-- [[ Basic Keymaps ]]
require 'maths-lover.keymaps'

-- [[ Neovide configuration ]]
require 'maths-lover.neovide'

-- [[ Basic Autocommands ]]
require 'maths-lover.autocmds'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
