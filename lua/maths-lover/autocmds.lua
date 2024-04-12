-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local maths_lover_group = vim.api.nvim_create_augroup('maths-lover', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  desc = 'Set colorschemes on startup',
  group = maths_lover_group,
  callback = function()
    -- wait for lazy.nvim to load before setting colorscheme
    vim.defer_fn(function()
      -- NOTE: Default colorscheme is set here
      local colorscheme_name = 'paradise'
      require('maths-lover.utils').set_colorscheme(colorscheme_name)
    end, 0)
  end,
})

vim.api.nvim_create_user_command('Color', function(args)
  local color = require('maths-lover.utils').set_colorscheme
  color(args['args'])
end, { desc = 'Set colorscheme using custom function', nargs = '*' })

-- vim: ts=2 sts=2 sw=2 et
