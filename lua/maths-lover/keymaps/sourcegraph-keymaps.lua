local _M = {}

_M.set_bindings = function()
  vim.keymap.set('n', '<leader>sS', function()
    require('sg.extensions.telescope').fuzzy_search_results()
  end, { desc = 'Fuzzy [S]earch Sourcegraph contents' })
end

return _M
