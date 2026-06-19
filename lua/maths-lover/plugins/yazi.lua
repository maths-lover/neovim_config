return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  -- yazi replaces both oil and netrw as the filesystem browser. Because
  -- open_for_directories is on, netrw must be disabled before it loads.
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    -- `-` keeps the muscle memory from oil: open the browser at the current file.
    { '-', '<cmd>Yazi<cr>', desc = 'Open yazi (at current file)' },
    { '<leader>e', '<cmd>Yazi<cr>', desc = 'Explorer (yazi at current file)' },
    { '<leader>E', '<cmd>Yazi cwd<cr>', desc = 'Explorer (yazi at cwd)' },
    -- Resume the last yazi session where you left it.
    { '<leader>fy', '<cmd>Yazi toggle<cr>', desc = 'Resume last yazi session' },
  },
  opts = {
    -- Open yazi instead of netrw when editing a directory (e.g. `nvim .`).
    open_for_directories = true,
    -- Keep yazi's own bindings; surface help on <f1>.
    keymaps = {
      show_help = '<f1>',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
