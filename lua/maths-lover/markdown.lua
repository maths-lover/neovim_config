-- Live markdown preview via inlyne — a standalone GPU-accelerated viewer.
-- Launches `inlyne <file>` in its own window; inlyne watches the file and
-- re-renders on every save, so the preview stays live as you write. No plugin
-- required. https://github.com/inlyne-project/inlyne

if vim.fn.executable 'inlyne' == 0 then
  return
end

-- Preview jobs keyed by absolute file path, so each markdown file gets at most
-- one viewer and we can close it again. Jobs are child processes of nvim, so
-- they exit when nvim does.
local jobs = {}

--- True when the current buffer is a markdown file worth previewing.
local function is_markdown()
  if vim.bo.filetype == 'markdown' then
    return true
  end
  local ext = vim.fn.expand('%:e'):lower()
  return ext == 'md' or ext == 'markdown'
end

--- Launch inlyne for the current file (or report it is already open).
local function open()
  if not is_markdown() then
    vim.notify('inlyne: not a markdown buffer', vim.log.levels.WARN)
    return
  end

  local file = vim.fn.expand '%:p'
  if file == '' then
    vim.notify('inlyne: buffer has no file on disk', vim.log.levels.WARN)
    return
  end

  if jobs[file] then
    vim.notify('inlyne: preview already open for this file', vim.log.levels.INFO)
    return
  end

  -- Match inlyne's theme to the editor background; `auto` follows the OS if the
  -- background is neither explicitly light nor dark.
  local theme = vim.o.background == 'light' and 'light' or 'dark'

  local job = vim.fn.jobstart({ 'inlyne', '--theme', theme, file }, {
    on_exit = function()
      jobs[file] = nil
    end,
  })

  if job <= 0 then
    vim.notify('inlyne: failed to launch', vim.log.levels.ERROR)
    return
  end

  jobs[file] = job
  vim.notify('inlyne: previewing ' .. vim.fn.expand '%:t', vim.log.levels.INFO)
end

--- Close the inlyne preview for the current file, if one is running.
local function close()
  local file = vim.fn.expand '%:p'
  local job = jobs[file]
  if not job then
    vim.notify('inlyne: no preview open for this file', vim.log.levels.INFO)
    return
  end
  vim.fn.jobstop(job)
  jobs[file] = nil
end

--- Toggle the preview for the current file.
local function toggle()
  if jobs[vim.fn.expand '%:p'] then
    close()
  else
    open()
  end
end

vim.keymap.set('n', '<leader>mp', open, { desc = 'Markdown preview (inlyne)' })
vim.keymap.set('n', '<leader>mq', close, { desc = 'Markdown preview close' })
vim.keymap.set('n', '<leader>mm', toggle, { desc = 'Markdown preview toggle' })

-- vim: ts=2 sts=2 sw=2 et
