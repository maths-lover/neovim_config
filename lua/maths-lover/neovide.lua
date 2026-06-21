if not vim.g.neovide then
  return
end

-- Gate macOS-only settings and Cmd-key (<D-...>) keymaps. Neovide silently
-- ignores the mac-only g: variables on other platforms, but the <D-...> maps
-- only make sense where a Command key exists, so keep them all behind this.
local is_mac = vim.fn.has 'mac' == 1

-- Font
vim.o.guifont = 'Monaspace Neon NF:h18'
vim.o.linespace = 2

-- Window appearance
vim.g.neovide_opacity = 1.0
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

-- Dynamic scale zoom (state lives here; the bindings are macOS-only below)
vim.g.neovide_scale_factor = 1.0

-- ----------------------------------------------------------------------------
-- macOS-specific configuration
-- ----------------------------------------------------------------------------
if is_mac then
  -- Treat both Option keys as Meta so <M-...> mappings fire instead of macOS
  -- inserting accented characters.
  vim.g.neovide_input_macos_option_key_is_meta = 'both'

  -- Blur the desktop behind a translucent window (macOS only; no-op at opacity 1
  -- but kept so lowering neovide_opacity later just works).
  vim.g.neovide_window_blurred = true

  -- Draw a subtle grey border around opaque windows for definition against the
  -- desktop (macOS only, default true — set explicitly).
  vim.g.neovide_show_border = true

  -- Expose the current file as a native title-bar proxy icon and reflect the
  -- buffer's modified state via the standard document-edited dot (macOS only).
  vim.g.neovide_proxy_icon = true

  -- Highlight the matching bracket pair using the system find indicator
  -- (macOS only, available since 0.16.0).
  vim.g.neovide_highlight_matching_pair = true

  -- Simple fullscreen: cover the screen and hide the dock/menu bar without
  -- macOS's native fullscreen Space + animation, so toggling is instant
  -- (macOS only, available since 0.15.1). Flip to false for native fullscreen.
  vim.g.neovide_macos_simple_fullscreen = true

  -- Standard macOS Cmd shortcuts (these only work in Neovide).
  vim.keymap.set('n', '<D-s>', '<cmd>w<CR>', { desc = 'Save file' })
  vim.keymap.set({ 'i', 'v' }, '<D-s>', '<Esc><cmd>w<CR>', { desc = 'Save file' })

  vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy to clipboard' })
  vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+p', { desc = 'Paste from clipboard' })
  vim.keymap.set('i', '<D-v>', '<C-r>+', { desc = 'Paste from clipboard' })
  vim.keymap.set('c', '<D-v>', '<C-r>+', { desc = 'Paste from clipboard' })
  vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pa', { desc = 'Paste from clipboard' })

  -- Cmd +/-/0 zoom (Cmd-= doubles as Cmd-+ without needing Shift).
  vim.keymap.set('n', '<D-=>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = 'Neovide zoom in' })

  vim.keymap.set('n', '<D-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
  end, { desc = 'Neovide zoom out' })

  vim.keymap.set('n', '<D-0>', function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = 'Neovide reset zoom' })
end

-- vim: ts=2 sts=2 sw=2 et
