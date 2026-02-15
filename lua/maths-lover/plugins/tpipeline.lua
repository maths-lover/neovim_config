return {
  'vimpostor/vim-tpipeline',
  lazy = false,
  init = function()
    vim.g.tpipeline_usepane = 1
  end,
  config = function()
    vim.o.laststatus = 0
    vim.o.showmode = false
  end,
}
