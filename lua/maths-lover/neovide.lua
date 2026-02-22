if not vim.g.neovide then
  return
end

-- Font
vim.o.guifont = 'CaskaydiaCove Nerd Font:h20'
vim.o.linespace = 2

-- Window appearance
vim.g.neovide_transparency = 0.93
vim.g.neovide_window_blurred = true
vim.g.neovide_padding_top = 8
vim.g.neovide_padding_bottom = 8
vim.g.neovide_padding_left = 12
vim.g.neovide_padding_right = 12
vim.g.neovide_theme = 'auto'

-- Floating window effects
vim.g.neovide_floating_blur_amount_x = 3.0
vim.g.neovide_floating_blur_amount_y = 3.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_corner_radius = 0.3

-- Cursor
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.4
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_vfx_mode = 'pixiedust'

-- Scroll & position animations
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_position_animation_length = 0.15

-- Input & display
vim.g.neovide_refresh_rate = 120
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_option_key_is_meta = 'both'

-- Neovide-only keymaps: standard macOS shortcuts
vim.keymap.set('n', '<D-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set({ 'i', 'v' }, '<D-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' })

vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<D-v>', '<C-r>+', { desc = 'Paste from clipboard' })
vim.keymap.set('c', '<D-v>', '<C-r>+', { desc = 'Paste from clipboard' })
vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pa', { desc = 'Paste from clipboard' })

-- Dynamic scale zoom
vim.g.neovide_scale_factor = 1.0

vim.keymap.set('n', '<D-=>', function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
end, { desc = 'Neovide zoom in' })

vim.keymap.set('n', '<D-->', function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
end, { desc = 'Neovide zoom out' })

vim.keymap.set('n', '<D-0>', function()
  vim.g.neovide_scale_factor = 1.0
end, { desc = 'Neovide reset zoom' })

-- vim: ts=2 sts=2 sw=2 et
