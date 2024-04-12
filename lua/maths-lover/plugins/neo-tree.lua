return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = function()
    local icon = require('maths-lover.utils').get_icon

    -- NOTE: There are mnore keymaps in the window_mappings and results_mappings below
    --
    -- main keymaps
    local win_mappings = require('maths-lover.keymaps.neo-tree-keymaps').window_mappings
    local main_mappings = require('maths-lover.keymaps.neo-tree-keymaps').main_mappings
    for _, mapping in ipairs(main_mappings) do
      vim.keymap.set(mapping.mode, mapping.key_trigger, mapping.action, mapping.opts)
    end

    return {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      source_selector = {
        winbar = true,
        content_layout = 'center',
        sources = {
          { source = 'filesystem', display_name = icon 'FolderClosed' .. ' File' },
          { source = 'buffers', display_name = icon 'DefaultFile' .. ' Bufs' },
          { source = 'git_status', display_name = icon 'Git' .. ' Git' },
          { source = 'diagnostics', display_name = icon 'Diagnostic' .. ' Diagnostic' },
        },
      },
      default_component_configs = {
        indent = { padding = 0, indent_size = 1 },
        icon = {
          folder_closed = icon 'FolderClosed',
          folder_open = icon 'FolderOpen',
          folder_empty = icon 'FolderEmpty',
          default = icon 'DefaultFile',
        },
        modified = { symbol = icon 'FileModified' },
        git_status = {
          symbols = {
            added = icon 'GitAdd',
            deleted = icon 'GitDelete',
            modified = icon 'GitChange',
            renamed = icon 'GitRenamed',
            untracked = icon 'GitUntracked',
            ignored = icon 'GitIgnored',
            unstaged = icon 'GitUnstaged',
            staged = icon 'GitStaged',
            conflict = icon 'GitConflict',
          },
        },
      },
      commands = {
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' or node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, seleect the next child
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          else -- if not a directory just open it
            state.commands.open(state)
          end
        end,
        copy_selector = function(state)
          local results = require('maths-lover.keymaps.neo-tree-keymaps').results_mappings(state)

          local messages = {
            { '\nChoose to copy to clipboard:\n', 'Normal' },
          }
          for i, result in pairs(results) do
            if result.val and result.val ~= '' then
              vim.list_extend(messages, {
                { ('%s.'):format(i), 'Identifier' },
                { (' %s: '):format(result.msg) },
                { result.val, 'String' },
                { '\n' },
              })
            end
          end
          vim.api.nvim_echo(messages, false, {})
          local result = results[vim.fn.getcharstr()]
          if result and result.val and result.val ~= '' then
            vim.notify('Copied: ' .. result.val)
            vim.fn.setreg('+', result.val)
          end
        end,
      },
      window = {
        width = 30,
        mappings = win_mappings,
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = true,
      },
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function(_)
            vim.opt_local.signcolumn = 'auto'
          end,
        },
      },
    }
  end,
}
