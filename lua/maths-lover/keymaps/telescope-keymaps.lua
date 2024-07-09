-- local telescope = package.loaded.telescope
local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

-- local actions = require 'telescope.actions'

local M = {}

M.default_mappings = {
  i = {
    ['<c-enter>'] = 'to_fuzzy_refine',
    ['<C-n>'] = actions.cycle_history_next,
    ['<C-p>'] = actions.cycle_history_prev,
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
  },
}

-- WARN: Following doesn't mean built-in mappings but mappings for built-in functions
-- for telescope
M.builtin_mappings = {
  {
    mode = 'n',
    key_trigger = '<leader>sh',
    action = builtin.help_tags,
    opts = { desc = '[S]earch [H]elp' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sk',
    action = builtin.keymaps,
    opts = { desc = '[S]earch [K]eymaps' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sf',
    action = builtin.find_files,
    opts = { desc = '[S]earch [F]iles' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>ss',
    action = builtin.builtin,
    opts = { desc = '[S]earch [S]elect Telescope' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sw',
    action = function()
      builtin.grep_string { search = vim.fn.expand '<cword>' }
    end,
    opts = { desc = '[S]earch current [w]ord' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sW',
    action = function()
      builtin.grep_string { search = vim.fn.expand '<cWORD>' }
    end,
    opts = { desc = '[S]earch current [W]ORD' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sg',
    action = builtin.live_grep,
    opts = { desc = '[S]earch by [G]rep' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sd',
    action = builtin.diagnostics,
    opts = { desc = '[S]earch [D]iagnostics' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sr',
    action = builtin.resume,
    opts = { desc = '[S]earch [R]esume' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>s.',
    action = builtin.oldfiles,
    opts = { desc = '[S]earch Recent Files ("." for repeat)' },
  },
  {
    mode = 'n',
    key_trigger = '<leader><leader>',
    action = builtin.buffers,
    opts = { desc = '[ ] Find existing buffers' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sGf',
    action = builtin.git_files,
    opts = { desc = '[S]earch [G]it files' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sGc',
    action = builtin.git_commits,
    opts = { desc = '[S]earch [G]it commits' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sGb',
    action = builtin.git_branches,
    opts = { desc = '[S]earch [G]it branches' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>/',
    action = function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    opts = { desc = '[/] Fuzzily search in current buffer' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>s/',
    action = function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    opts = { desc = '[S]earch [/] in Open Files' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sn',
    action = function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end,
    opts = { desc = '[S]earch [N]eovim files' },
  },
  {
    mode = 'n',
    key_trigger = '<leader>sz',
    action = function()
      builtin.find_files {
        cwd = os.getenv 'ZDOTDIR',
        find_command = function()
          local zsh_search_path = os.getenv 'ZDOTDIR'
          return {
            'fd',
            '-H',
            '--color',
            'never',
            '--follow',
            '--regex',
            '.z((login)|(logout)|(preztorc)|(profile)|(shenv)|(shrc))|starship|dot_alias',
            zsh_search_path,
          }
        end,
        hidden = true,
      }
    end,
    opts = { desc = '[S]earch [Z]sh files' },
  },
}

return M
