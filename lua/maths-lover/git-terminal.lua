-- Native floating terminal for lazygit — replaces the lazygit.nvim plugin.
-- Opens lazygit in a bordered float using the built-in terminal, and refreshes
-- the gitsigns gutter when it exits. No plugin required.

if vim.fn.executable 'lazygit' == 0 then
  return
end

--- Open `cmd` in a centered floating terminal; refresh gitsigns on exit.
---@param cmd string[] command + args to run
---@param cwd string? working directory (defaults to current)
local function open_lazygit(cmd, cwd)
  local width = math.floor(vim.o.columns * 0.95)
  local height = math.floor(vim.o.lines * 0.92)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' lazygit ',
    title_pos = 'center',
  })

  vim.fn.jobstart(cmd, {
    term = true,
    cwd = cwd,
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
      -- reflect any commits/stages lazygit made in the sign column
      pcall(function()
        require('gitsigns').refresh()
      end)
    end,
  })

  vim.cmd.startinsert()
end

--- Git root of the current file, falling back to the cwd.
local function file_git_root()
  return vim.fs.root(0, '.git') or vim.fn.getcwd()
end

vim.keymap.set('n', '<leader>gg', function()
  open_lazygit { 'lazygit' }
end, { desc = 'Lazygit (cwd)' })

vim.keymap.set('n', '<leader>gG', function()
  open_lazygit({ 'lazygit' }, file_git_root())
end, { desc = 'Lazygit (current file repo)' })

vim.keymap.set('n', '<leader>gl', function()
  open_lazygit { 'lazygit', '-f', vim.fn.expand '%:p' }
end, { desc = 'Lazygit log (current file)' })

-- vim: ts=2 sts=2 sw=2 et
