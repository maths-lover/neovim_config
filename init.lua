-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'maths-lover.options'
-- or overwrite options with your own options
-- require 'your_username.options'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'maths-lover.lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'maths-lover.lazy-plugins'

-- [[ Basic Keymaps ]]
require 'maths-lover.keymaps'
-- or overwrite them with your own keymaps
-- require 'your_username.keymaps'

-- [[ Neovide configuration ]]
require 'maths-lover.neovide'
-- or overwrite them with your own neovide config
-- require 'maths-lover.neovide'

-- [[ Basic Autocommands ]]
require 'maths-lover.autocmds'
-- or include more with your own
-- require 'your_username.autocmds'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
