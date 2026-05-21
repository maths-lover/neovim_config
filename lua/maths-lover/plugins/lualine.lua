return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- rose-pine-dawn palette matching starship.toml
    local c = {
      fg = '#575279', -- text (dark) — fg on neutral light pills
      bg = '#faf4ed', -- base — statusline background
      muted = '#575279', -- dark text — fg on saturated colored pills (contrast)
      box = '#dfdad9', -- highlight_med — bg for neutral grey pills (diff, progress)
      surface = '#cecacd', -- highlight_high — bg for filename / diagnostics pills
      subtle = '#9893a5', -- muted — fg for inactive / ghost-pill text
      blue = '#286983', -- pine
      cyan = '#56949f', -- foam
      green = '#56949f', -- foam
      orange = '#ea9d34', -- gold
      pink = '#d7827e', -- rose
      purple = '#907aa9', -- iris
      red = '#b4637a', -- love
    }

    -- icons via hex escapes so they survive file writes
    local icons = {
      branch = '\xee\x9c\xa5', -- U+E725 (git_branch)
      added = '\xef\x93\x90 ', -- U+F4D0 (staged)
      modified = '\xee\xb8\xbc ', -- U+EE3C (modified)
      removed = '\xee\xaa\x81 ', -- U+EA81 (deleted)
      readonly = '\xf3\xb1\xa7\xb4 ', -- U+F19F4 (readonly)
      error = '\xee\xaa\x87 ', -- U+EA87 (error)
      warn = '\xee\xa9\xac ', -- U+EA6C (warning)
      info = '\xee\xa9\xb4 ', -- U+EA74 (info)
      hint = '\xf3\xb0\x8c\xb5 ', -- U+F0335 (lightbulb)
    }

    local pill = {
      left = '\xee\x82\xb6', -- U+E0B6 ()
      right = '\xee\x82\xb4', -- U+E0B4 ()
    }

    -- mode-dependent accent color
    local mode_color = {
      n = c.cyan,
      i = c.green,
      v = c.purple,
      ['\22'] = c.purple,
      V = c.purple,
      c = c.orange,
      R = c.red,
      s = c.pink,
      S = c.pink,
      ['\19'] = c.pink,
      t = c.blue,
    }

    -- transparent theme — pills get color via per-component `color`
    local theme = {
      normal = {
        a = { bg = c.bg },
        b = { bg = c.bg },
        c = { fg = c.fg, bg = c.bg },
      },
      inactive = {
        a = { bg = c.bg },
        b = { bg = c.bg },
        c = { fg = c.subtle, bg = c.bg },
      },
    }

    require('lualine').setup {
      options = {
        theme = theme,
        component_separators = '',
        section_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            separator = pill,
            color = function()
              return { fg = c.muted, bg = mode_color[vim.fn.mode()] or c.cyan, gui = 'bold' }
            end,
          },
        },
        lualine_b = {
          {
            'branch',
            icon = icons.branch,
            separator = pill,
            color = { fg = c.muted, bg = c.orange },
          },
          {
            'diff',
            symbols = { added = icons.added, modified = icons.modified, removed = icons.removed },
            separator = pill,
            color = { fg = c.fg, bg = c.box },
          },
          {
            'filename',
            path = 1,
            symbols = { readonly = icons.readonly },
            separator = pill,
            color = { fg = c.fg, bg = c.surface },
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            'diagnostics',
            symbols = { error = icons.error, warn = icons.warn, info = icons.info, hint = icons.hint },
            separator = pill,
            color = { fg = c.fg, bg = c.surface },
          },
          {
            'filetype',
            separator = pill,
            color = { fg = c.muted, bg = c.green },
          },
        },
        lualine_y = {
          {
            'progress',
            separator = pill,
            color = { fg = c.fg, bg = c.box },
          },
        },
        lualine_z = {
          {
            'location',
            separator = pill,
            color = { fg = c.muted, bg = c.purple },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {
          {
            'filename',
            path = 1,
            separator = pill,
            color = { fg = c.subtle, bg = c.box },
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            'location',
            separator = pill,
            color = { fg = c.subtle, bg = c.box },
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
