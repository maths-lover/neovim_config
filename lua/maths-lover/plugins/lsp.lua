return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('maths-lover_lsp_attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = buf, desc = desc })
          end

          local builtin = require 'telescope.builtin'

          -- Navigation (use telescope for multi-result pickers)
          map('gd', builtin.lsp_definitions, 'Go to definition')
          map('gr', builtin.lsp_references, 'Go to references')
          map('gi', builtin.lsp_implementations, 'Go to implementation')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')

          -- Hover
          map('K', vim.lsp.buf.hover, 'Hover documentation')

          -- Code actions (under <leader>c)
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
          map('<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
          map('<leader>cl', vim.diagnostic.open_float, 'Line diagnostics')
          map('<leader>cs', builtin.lsp_document_symbols, 'Document symbols')
          map('<leader>cS', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
          map('<leader>ct', builtin.lsp_type_definitions, 'Type definition')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Inlay hints (native, 0.10+): on by default, <leader>ch toggles.
          if client and client:supports_method 'textDocument/inlayHint' then
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            map('<leader>ch', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
            end, 'Toggle inlay hints')
          end

          -- Document highlight (native): underline/highlight other uses of the
          -- symbol under the cursor while it rests there; cleared on move.
          if client and client:supports_method 'textDocument/documentHighlight' then
            local hl = vim.api.nvim_create_augroup('maths-lover_lsp_highlight_' .. buf, { clear = true })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = hl,
              buffer = buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = hl,
              buffer = buf,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('maths-lover_lsp_detach_' .. buf, { clear = true }),
              buffer = buf,
              callback = function()
                vim.lsp.buf.clear_references()
                pcall(vim.api.nvim_clear_autocmds, { group = hl, buffer = buf })
              end,
            })
          end
        end,
      })
    end,
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      widget_guides = { enabled = true },
      closing_tags = {
        enabled = true,
        prefix = '// ',
      },
      lsp = {
        color = {
          enabled = true,
          virtual_text = true,
        },
        settings = {
          completeFunctionCalls = true,
          enableSnippets = true,
          enableSdkFormatter = true,
          lineLength = 80,
          renameFilesWithClasses = 'prompt',
          analysisExcludedFolders = {
            vim.fn.expand '$HOME/.pub-cache',
          },
        },
        capabilities = function(config)
          local has_blink, blink = pcall(require, 'blink.cmp')
          if has_blink then
            config.capabilities = blink.get_lsp_capabilities(config.capabilities)
          end
          return config
        end,
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
