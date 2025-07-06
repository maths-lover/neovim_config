-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- NOTE: Any plugin specific keymap if it is not present here then look into plugin's lua file how it is being sourced
-- It might be present in plugin's keymap file in the keymaps directory

-- source the current file to bring changes
vim.keymap.set('n', '<leader><leader>x', '<cmd>so %<CR>', { desc = 'Source current file for neovim' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Set j to actually go down visually instead of linewise
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Use arrow keys to split the window in those direction
vim.keymap.set('n', '<left>', function()
  -- first set direction to left
  vim.opt.splitright = false
  vim.cmd 'vsplit'
end, { desc = 'Split window left' })
vim.keymap.set('n', '<right>', function()
  -- first set direction to right
  vim.opt.splitright = true
  vim.cmd 'vsplit'
end, { desc = 'Split window right' })
vim.keymap.set('n', '<up>', function()
  -- first set direction to up
  vim.opt.splitbelow = false
  vim.cmd 'split'
end, { desc = 'Split window up' })
vim.keymap.set('n', '<down>', function()
  -- first set direction to down
  vim.opt.splitbelow = true
  vim.cmd 'split'
end, { desc = 'Split window down' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Set Control-{left,right,up,down} to grow or shrink split windows
vim.keymap.set('n', '<C-left>', '<C-w><', { desc = 'Shrink width' })
vim.keymap.set('n', '<C-right>', '<C-w>>', { desc = 'Grow width' })
vim.keymap.set('n', '<C-up>', '<C-w>+', { desc = 'Grow height' })
vim.keymap.set('n', '<C-down>', '<C-w>-', { desc = 'Shrink height' })
vim.keymap.set('n', '<C-z>', '<C-w>_<C-w>|', { desc = 'Zoom the selected window' })

-- Set Alt-{h,j,k,l} to swap windows
vim.keymap.set('n', '<A-h>', '<C-w>H', { desc = 'Swap buffer window to left buffer window' })
vim.keymap.set('n', '<A-l>', '<C-w>L', { desc = 'Swap buffer window to right buffer window' })
vim.keymap.set('n', '<A-j>', '<C-w>J', { desc = 'Swap buffer window to below buffer window' })
vim.keymap.set('n', '<A-k>', '<C-w>K', { desc = 'Swap buffer window to upper buffer window' })

-- Close selected buffer window
vim.keymap.set('n', '<leader>q', '<C-w>c', { desc = 'Close buffer' })
-- Close all other buffer windows except selected buffer window
vim.keymap.set('n', '<leader>Q', '<C-w>o', { desc = 'Close all other buffers except selected one' })

-- open a new file
vim.keymap.set('n', '<leader>n', '<cmd>enew<CR>', { desc = 'Open a new file' })

-- Tabs
vim.keymap.set('n', '<leader>N', '<cmd>tabnew<CR>', { desc = 'Create a buffer in new tab' })
-- use <C-tab> and <C-shift-tab> to change tabs
vim.keymap.set('n', '<leader><tab>', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader><S-tab>', '<cmd>tabprevious<CR>', { desc = 'Go to previous tab' })

-- vim: ts=2 sts=2 sw=2 et
