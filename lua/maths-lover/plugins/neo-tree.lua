return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle file tree' },
    { '<leader>E', '<cmd>Neotree reveal<CR>', desc = 'Reveal current file in tree' },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'disabled', -- let oil.nvim handle netrw
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      position = 'left',
      width = 35,
      mappings = {
        ['<space>'] = 'none', -- free up space so leader keys work inside the tree
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = '',
        expander_expanded = '',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
      },
      modified = {
        symbol = '●',
      },
      git_status = {
        symbols = {
          added = '✚',
          modified = '',
          deleted = '✖',
          renamed = '󰁕',
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
