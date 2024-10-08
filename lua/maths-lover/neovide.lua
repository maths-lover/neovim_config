if vim.g.neovide then
  -- vim.opt.guifont = 'VictorMono Nerd Font:h16'
  -- vim.opt.guifont = '0xProto Nerd Font:h12'
  vim.opt.guifont = 'MartianMono Nerd Font Propo:h12'
  vim.g.neovide_floating_blur_amount_x = 1.0
  vim.g.neovide_floating_blur_amount_y = 1.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_hide_mouse_when_typing = true
  -- vim.g.neovide_transparency = 0.9
  vim.g.neovide_refresh_rate = 75
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_animation_length = 0.0
  -- vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_vfx_mode = 'wireframe'
  -- vim.g.neovide_cursor_vfx_particle_density = 18.0
  -- vim.g.neovide_cursor_vfx_particle_speed = 8.0
  -- vim.g.neovide_cursor_vfx_particle_lifetime = 1.8
  -- vim.g.neovide_cursor_vfx_particle_curl = 0.1
  vim.g.neovide_input_use_logo = true
  vim.api.nvim_set_keymap('n', '<M-v>', '+p<CR>', { noremap = true, silent = false })
  vim.api.nvim_set_keymap('!', '<M-v>', '<C-R>+', { noremap = true, silent = false })
  vim.api.nvim_set_keymap('t', '<M-v>', '<C-R>+', { noremap = true, silent = false })
  vim.api.nvim_set_keymap('v', '<Mv>', '<C-R>+', { noremap = true, silent = false })
end

-- vim: ts=2 sts=2 sw=2 et
