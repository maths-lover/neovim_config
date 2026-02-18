return {
  'vimpostor/vim-tpipeline',
  lazy = false,
  init = function()
    vim.g.tpipeline_autoembed = 0
    vim.g.tpipeline_restore = 1
    vim.g.tpipeline_clearstl = 1
  end,
  config = function()
    vim.api.nvim_create_autocmd('OptionSet', {
      group = vim.api.nvim_create_augroup('maths-lover_tpipeline', { clear = true }),
      pattern = 'laststatus',
      callback = function()
        if vim.o.laststatus ~= 0 then
          vim.o.laststatus = 0
        end
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
