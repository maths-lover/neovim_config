local ascii_text = {
  [[      ___           ___           ___           ___           ___     ]],
  [[     /\__\         /\  \         /\  \         /\__\         /\  \    ]],
  [[    /::|  |       /::\  \        \:\  \       /:/  /        /::\  \   ]],
  [[   /:|:|  |      /:/\:\  \        \:\  \     /:/__/        /:/\ \  \  ]],
  [[  /:/|:|__|__   /::\~\:\  \       /::\  \   /::\  \ ___   _\:\~\ \  \ ]],
  [[ /:/ |::::\__\ /:/\:\ \:\__\     /:/\:\__\ /:/\:\  /\__\ /\ \:\ \ \__\]],
  [[ \/__/~~/:/  / \/__\:\/:/  /    /:/  \/__/ \/__\:\/:/  / \:\ \:\ \/__/]],
  [[       /:/  /       \::/  /    /:/  /           \::/  /   \:\ \:\__\  ]],
  [[      /:/  /        /:/  /     \/__/            /:/  /     \:\/:/  /  ]],
  [[     /:/  /        /:/  /                      /:/  /       \::/  /   ]],
  [[     \/__/         \/__/                       \/__/         \/__/    ]],
  [[      ___       ___           ___           ___           ___         ]],
  [[     /\__\     /\  \         /\__\         /\  \         /\  \        ]],
  [[    /:/  /    /::\  \       /:/  /        /::\  \       /::\  \       ]],
  [[   /:/  /    /:/\:\  \     /:/  /        /:/\:\  \     /:/\:\  \      ]],
  [[  /:/  /    /:/  \:\  \   /:/__/  ___   /::\~\:\  \   /::\~\:\  \     ]],
  [[ /:/__/    /:/__/ \:\__\  |:|  | /\__\ /:/\:\ \:\__\ /:/\:\ \:\__\    ]],
  [[ \:\  \    \:\  \ /:/  /  |:|  |/:/  / \:\~\:\ \/__/ \/_|::\/:/  /    ]],
  [[  \:\  \    \:\  /:/  /   |:|__/:/  /   \:\ \:\__\      |:|::/  /     ]],
  [[   \:\  \    \:\/:/  /     \::::/__/     \:\ \/__/      |:|\/__/      ]],
  [[    \:\__\    \::/  /       ~~~~          \:\__\        |:|  |        ]],
  [[     \/__/     \/__/                       \/__/         \|__|        ]],
}

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, highlight = true },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = ascii_text
    dashboard.section.buttons.val = {
      dashboard.button('n', ' ' .. 'New file', ':enew<CR>'),
      dashboard.button('r', ' ' .. 'Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('f', ' ' .. 'Find files', ':Telescope find_files<CR>'),
      dashboard.button('t', ' ' .. 'Change theme', ':Telescope colorscheme<CR>'),
      dashboard.button('l', ' ' .. 'LazyUI', ':Lazy <CR>'),
      dashboard.button('q', '󰗼 ' .. 'Quit', ':q<CR>'),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local v = vim.version()
        local dev = ''
        if v.prerelease == 'dev' then
          dev = '-dev+' .. v.build
        else
          dev = ''
        end
        local version = v.major .. '.' .. v.minor .. '.' .. v.patch .. dev
        local stats = require('lazy').stats()
        local plugins_count = stats.loaded .. '/' .. stats.count
        local ms = math.floor(stats.startuptime + 0.5)
        local time = vim.fn.strftime '%H:%M:%S'
        local date = vim.fn.strftime '%d.%m.%Y'
        local line1 = ' ' .. plugins_count .. ' plugins loaded in ' .. ms .. 'ms'
        local line2 = '󰃭 ' .. date .. '  ' .. time
        local line3 = ' ' .. version

        local line1_width = vim.fn.strdisplaywidth(line1)
        local line2Padded = string.rep(' ', (line1_width - vim.fn.strdisplaywidth(line2)) / 2) .. line2
        local line3Padded = string.rep(' ', (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3

        dashboard.section.footer.val = {
          line1,
          line2Padded,
          line3Padded,
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    alpha.setup(dashboard.config)
  end,
}
-- return {
--   'goolord/alpha-nvim',
--   event = 'VimEnter',
--   dependencies = { 'nvim-tree/nvim-web-devicons' },
--   opts = function()
--     local dashboard = require 'alpha.themes.dashboard'
--     require 'alpha.term'
--     local arttoggle = false
--
--     local logo = {
--       [[                                                    ]],
--       [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
--       [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
--       [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
--       [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
--       [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
--       [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
--       [[                                                    ]],
--     }
--
--     local art = {
--       -- { name, width, height }
--       { 'tohru', 62, 17 },
--     }
--
--     if arttoggle == true then
--       dashboard.opts.opts.noautocmd = true
--       dashboard.section.terminal.opts.redraw = true
--       local path = vim.fn.stdpath 'config' .. '/assets/'
--       -- local random = math.random(1, #art)
--       local currentart = art[1]
--       dashboard.section.terminal.command = 'cat ' .. path .. currentart[1]
--
--       dashboard.section.terminal.width = currentart[2]
--       dashboard.section.terminal.height = currentart[3]
--
--       dashboard.opts.layout = {
--         dashboard.section.terminal,
--         { type = 'padding', val = 2 },
--         dashboard.section.buttons,
--         dashboard.section.footer,
--       }
--     else
--       dashboard.section.header.val = logo
--     end
--     dashboard.section.buttons.val = {
--       dashboard.button('f', ' ' .. 'Find files', ':Telescope find_files <CR>'),
--       dashboard.button('p', ' ' .. 'Select project', ':Telescope neovim-project history <CR>'),
--       dashboard.button('t', ' ' .. 'Change theme', ':ThemeSwitcher <CR>'),
--       dashboard.button('n', ' ' .. 'Neorg', ':Neorg workspace main <CR>'),
--       dashboard.button('l', '󰚰 ' .. 'LazyUI', ':Lazy <CR>'),
--     }
--     for _, button in ipairs(dashboard.section.buttons.val) do
--       button.opts.hl = 'AlphaButtons'
--       button.opts.hl_shortcut = 'AlphaShortcut'
--     end
--     dashboard.section.header.opts.hl = 'Function'
--     dashboard.section.buttons.opts.hl = 'Identifier'
--     dashboard.section.footer.opts.hl = 'Function'
--     dashboard.opts.layout[1].val = 4
--     return dashboard
--   end,
--   config = function(_, dashboard)
--     if vim.o.filetype == 'lazy' then
--       vim.cmd.close()
--       vim.api.nvim_create_autocmd('User', {
--         pattern = 'AlphaReady',
--         callback = function()
--           require('lazy').show()
--         end,
--       })
--     end
--     require('alpha').setup(dashboard.opts)
--     vim.api.nvim_create_autocmd('User', {
--       pattern = 'LazyVimStarted',
--       callback = function()
--         local v = vim.version()
--         local dev = ''
--         if v.prerelease == 'dev' then
--           dev = '-dev+' .. v.build
--         else
--           dev = ''
--         end
--         local version = v.major .. '.' .. v.minor .. '.' .. v.patch .. dev
--         local stats = require('lazy').stats()
--         local plugins_count = stats.loaded .. '/' .. stats.count
--         local ms = math.floor(stats.startuptime + 0.5)
--         local time = vim.fn.strftime '%H:%M:%S'
--         local date = vim.fn.strftime '%d.%m.%Y'
--         local line1 = ' ' .. plugins_count .. ' plugins loaded in ' .. ms .. 'ms'
--         local line2 = '󰃭 ' .. date .. '  ' .. time
--         local line3 = ' ' .. version
--
--         local line1_width = vim.fn.strdisplaywidth(line1)
--         local line2Padded = string.rep(' ', (line1_width - vim.fn.strdisplaywidth(line2)) / 2) .. line2
--         local line3Padded = string.rep(' ', (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3
--
--         dashboard.section.footer.val = {
--           line1,
--           line2Padded,
--           line3Padded,
--         }
--         pcall(vim.cmd.AlphaRedraw)
--       end,
--     })
--   end,
-- }
