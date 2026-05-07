return {
  'kdheepak/lazygit.nvim',
  cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Lazygit (cwd)' },
    { '<leader>gG', '<cmd>LazyGitCurrentFile<CR>', desc = 'Lazygit (current file repo)' },
    { '<leader>gl', '<cmd>LazyGitFilterCurrentFile<CR>', desc = 'Lazygit log (current file)' },
  },
  init = function()
    -- floating window styling — keep it minimal
    vim.g.lazygit_floating_window_scaling_factor = 0.95
    vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
    vim.g.lazygit_use_neovim_remote = 0
  end,
  config = function()
    -- refresh gitsigns after lazygit closes so the gutter reflects new state
    vim.api.nvim_create_autocmd('TermClose', {
      group = vim.api.nvim_create_augroup('maths-lover_lazygit_refresh', { clear = true }),
      pattern = '*lazygit*',
      callback = function()
        local ok, gitsigns = pcall(require, 'gitsigns')
        if ok then
          gitsigns.refresh()
        end
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
