-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- NOTE: Any plugin specific keymap if it is not present here then look into plugin's lua file
-- It might be present in plugin's init function

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

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
vim.keymap.set('n', '<C-=>', '<C-w>=', { desc = 'Set width and height in equal proportion' })

-- Set Alt-{h,j,k,l} to swap windows
vim.keymap.set('n', '<A-h>', '<C-w>H', { desc = 'Swap buffer window to left buffer window' })
vim.keymap.set('n', '<A-l>', '<C-w>L', { desc = 'Swap buffer window to right buffer window' })
vim.keymap.set('n', '<A-j>', '<C-w>J', { desc = 'Swap buffer window to below buffer window' })
vim.keymap.set('n', '<A-k>', '<C-w>K', { desc = 'Swap buffer window to upper buffer window' })

-- Close selected buffer window
vim.keymap.set('n', '<leader>q', '<C-w>c', { desc = 'Close buffer' })
-- Close all other buffer windows except selected buffer window
vim.keymap.set('n', '<leader>Q', '<C-w>o', { desc = 'Close all other buffers except selected one' })

-- vim: ts=2 sts=2 sw=2 et
