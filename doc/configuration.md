# Neovim Configuration Reference

## Directory Structure

```
~/.config/nvim/
├── init.lua                          # Entry point
├── doc/
│   ├── configuration.md              # This file
│   └── flutter-guide.md              # Flutter development guide
└── lua/maths-lover/
    ├── options.lua                    # Editor settings
    ├── keymaps.lua                    # Core key mappings
    ├── autocmds.lua                   # Autocommands
    ├── lazy.lua                       # Plugin manager bootstrap
    └── plugins/
        ├── init.lua                   # Empty (specs in individual files)
        ├── treesitter.lua             # Syntax, textobjects, context
        ├── which-key.lua              # Keymap discovery popup
        ├── telescope.lua              # Fuzzy finder (rg + fd)
        ├── lsp.lua                    # LSP + flutter-tools
        ├── completion.lua             # blink.cmp + snippets
        ├── colorscheme.lua            # pinot_noir, rose-pine, gruvbox, nord
        ├── git.lua                    # gitsigns + diffview
        ├── oil.lua                    # File explorer
        ├── conform.lua                # Auto-formatter
        ├── todo-comments.lua          # TODO/FIXME highlighter
        └── lualine.lua                # Statusline
```

## Core Settings (options.lua)

| Setting | Value | Notes |
|---------|-------|-------|
| Leader | `<Space>` | Both leader and localleader |
| Line numbers | Relative + absolute | |
| Tabs | 2-space, expanded | tabstop=2, shiftwidth=2, expandtab |
| Search | Case-insensitive + smartcase | hlsearch on, `<Esc>` to clear |
| Clipboard | Synced with OS | Disabled over SSH |
| Folds | Treesitter-based | All open by default (foldlevel=99) |
| Signcolumn | 2 columns | For gitsigns + diagnostics |
| Statusline | Global (laststatus=3) | Single bar across all splits |
| Showmode | Off | Lualine shows mode instead |
| Scrolloff | 10 lines | |
| Undo | Persistent (undofile) | |
| Whitespace | Visible | tabs=→, trail=·, eol=↵, lead=·, nbsp=␣ |
| Bigfile | >1.5MB disables plugins | |

## Plugin Manager — lazy.nvim

- Auto-bootstraps on first launch
- Plugin specs loaded from `lua/maths-lover/plugins/`
- `:Lazy` to open the dashboard (install, update, clean, profile)
- `lazy-lock.json` pins exact versions (gitignored)

## Installed Plugins

| Plugin | Purpose | Load |
|--------|---------|------|
| nvim-treesitter | Parser management, highlighting, indentation | Eager |
| nvim-treesitter-textobjects | Syntax-aware text objects and motions | With treesitter |
| nvim-treesitter-context | Sticky function/class header (max 3 lines) | With treesitter |
| which-key.nvim | Keymap popup on partial input | VeryLazy |
| telescope.nvim | Fuzzy finder UI | VimEnter |
| telescope-fzf-native.nvim | Native fzf sorter (compiled C) | With telescope |
| telescope-ui-select.nvim | Replaces vim.ui.select | With telescope |
| nvim-lspconfig | LSP client configuration | BufReadPre |
| flutter-tools.nvim | Dart/Flutter LSP + widget enhancements | ft=dart |
| blink.cmp | Autocompletion | With lspconfig |
| friendly-snippets | VSCode-format snippet collection | With blink.cmp |
| pinot_noir.nvim | Primary colorscheme (local, noir style) | Eager, priority=1000 |
| colorbuddy.nvim | Colorscheme helper (pinot_noir dependency) | With pinot_noir |
| rose-pine | Colorscheme (alternative) | Lazy |
| gruvbox.nvim | Colorscheme (alternative) | Lazy |
| nord.nvim | Colorscheme (alternative) | Lazy |
| gitsigns.nvim | Git signs in gutter, hunk operations | BufReadPre |
| diffview.nvim | Side-by-side diff viewer | On command |
| oil.nvim | File explorer (edit filesystem as buffer) | Eager |
| conform.nvim | Code formatter (format on save) | BufWritePre |
| todo-comments.nvim | Highlight TODO/FIXME/HACK in comments | BufReadPre |
| lualine.nvim | Statusline | Eager |
| plenary.nvim | Lua utility library (dependency) | — |
| nvim-web-devicons | File icons (dependency) | — |

## Installed Treesitter Parsers

lua, vim, vimdoc, markdown, markdown_inline, python, dart, go, c, cpp, rust, javascript, typescript, html, css, json, yaml, toml, bash, sql, java

---

## Complete Keymap Reference

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | n | Leader key |
| `<leader><leader>x` | n | Source current file |
| `<Esc>` | n | Clear search highlight |
| `j` / `k` | n | Move visually (not linewise) |
| `<Esc><Esc>` | t | Exit terminal mode |

### Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<left>` | n | Split left |
| `<right>` | n | Split right |
| `<up>` | n | Split up |
| `<down>` | n | Split down |
| `<C-h/j/k/l>` | n | Move focus between windows |
| `<C-left/right>` | n | Resize width |
| `<C-up/down>` | n | Resize height |
| `<C-z>` | n | Zoom current window |
| `<A-h/j/k/l>` | n | Swap window position |
| `<leader>q` | n | Close current window |
| `<leader>Q` | n | Close all other windows |

### Buffers & Tabs

| Key | Mode | Action |
|-----|------|--------|
| `<leader>n` | n | New file |
| `<leader>N` | n | New tab |
| `<leader><tab>` | n | Next tab |
| `<leader><S-tab>` | n | Previous tab |

### Search — `<leader>s` (Telescope)

| Key | Mode | Action | Backend |
|-----|------|--------|---------|
| `<leader>sf` | n | Find files | fd |
| `<leader>sg` | n | Live grep | rg |
| `<leader>sw` | n | Grep word under cursor | rg |
| `<leader>sb` | n | Open buffers | — |
| `<leader>s.` | n | Recent files | — |
| `<leader>s/` | n | Fuzzy find in current buffer | — |
| `<leader>sh` | n | Help tags | — |
| `<leader>sk` | n | All keymaps | — |
| `<leader>sr` | n | Resume last picker | — |
| `<leader>sd` | n | Diagnostics | — |
| `<leader>st` | n | Treesitter symbols | — |
| `<leader>sc` | n | Git commits | git |
| `<leader>ss` | n | Git status | git |
| `<leader>sC` | n | Colorschemes (live preview) | — |
| `<leader>sT` | n | Search TODOs | — |
| `<leader>?` | n | Show all keymaps (which-key) | — |

**Inside Telescope picker:**

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next / previous item |
| `<CR>` | Open selected |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send to quickfix list |
| `<Tab>` / `<S-Tab>` | Toggle multi-select |
| `<C-u>` / `<C-d>` | Scroll preview |

**fzf-native syntax in search prompts:**

| Pattern | Meaning |
|---------|---------|
| `sbtrkt` | Fuzzy match |
| `'exact` | Exact match |
| `^prefix` | Starts with |
| `suffix$` | Ends with |
| `!exclude` | Does not match |
| `foo\|bar` | Either pattern |

### Code — `<leader>c` (LSP)

These activate when an LSP server attaches to a buffer.

| Key | Mode | Action | Via |
|-----|------|--------|----|
| `gd` | n | Go to definition | Telescope |
| `gr` | n | References | Telescope |
| `gi` | n | Implementation | Telescope |
| `gD` | n | Declaration | vim.lsp |
| `K` | n | Hover documentation | vim.lsp |
| `<leader>ca` | n, v | Code action | vim.lsp |
| `<leader>cr` | n | Rename symbol | vim.lsp |
| `<leader>cd` | n | Line diagnostics (float) | vim.diagnostic |
| `<leader>cs` | n | Document symbols | Telescope |
| `<leader>cS` | n | Workspace symbols | Telescope |
| `<leader>cD` | n | Type definition | Telescope |
| `<leader>cf` | n | Format buffer | conform.nvim |

### Treesitter Text Objects

| Key | Mode | Action |
|-----|------|--------|
| `af` / `if` | x, o | Select outer/inner function |
| `ac` / `ic` | x, o | Select outer/inner class |
| `aa` / `ia` | x, o | Select outer/inner parameter |
| `]m` / `[m` | n, x, o | Next/previous function start |
| `]M` / `[M` | n, x, o | Next/previous function end |
| `]]` / `[[` | n, x, o | Next/previous class start |
| `][` / `[]` | n, x, o | Next/previous class end |
| `<leader>a` | n | Swap with next parameter |
| `<leader>A` | n | Swap with previous parameter |

### Hunk (Git) — `<leader>h` (gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `]c` / `[c` | n | Next/previous hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage entire buffer |
| `<leader>hR` | n | Reset entire buffer |
| `<leader>hp` | n | Preview hunk in float |
| `<leader>hb` | n | Blame current line |
| `<leader>hd` | n | Diff this file |
| `ih` | o, x | Select hunk (text object) |

### Git — `<leader>g` (diffview)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gd` | n | Open diff view (working tree vs index) |
| `<leader>gh` | n | File history for current file |
| `<leader>gq` | n | Close diff view |

**Inside diffview:**

| Key | Action |
|-----|--------|
| `<tab>` / `<s-tab>` | Cycle files |
| `s` / `-` | Stage/unstage entry |
| `S` / `U` | Stage/unstage all |
| `[x` / `]x` | Previous/next conflict |
| `<leader>co` | Accept ours |
| `<leader>ct` | Accept theirs |
| `<leader>cb` | Accept base |

### TODO Navigation

| Key | Mode | Action |
|-----|------|--------|
| `]t` / `[t` | n | Next/previous TODO comment |
| `<leader>sT` | n | Search all TODOs (Telescope) |

### File Explorer (oil.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `-` | n | Open parent directory |

**Inside oil buffer:**

| Key | Action |
|-----|--------|
| `<CR>` | Open file / enter directory |
| `-` | Go to parent directory |
| `g.` | Toggle hidden files |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `g?` | Show help |

To rename: edit the filename text, then `:w`
To delete: delete the line, then `:w`
To create: add a new line with a filename, then `:w`

### Completion (blink.cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-space>` | i | Trigger completion |
| `<C-y>` | i | Accept selected item |
| `<C-e>` | i | Dismiss completion |
| `<C-n>` / `<C-j>` | i | Next item |
| `<C-p>` / `<C-k>` | i | Previous item |
| `<C-b>` / `<C-f>` | i | Scroll documentation |
| `<Tab>` / `<S-Tab>` | i | Jump snippet placeholders |

---

## Autocommands

| Event | Action |
|-------|--------|
| TextYankPost | Briefly highlight yanked text |
| VimResized | Auto-equalize split sizes |
| BufReadPost | Restore cursor position |
| FileType (help, qf, etc.) | Close with `q` |
| FileType (text, markdown, etc.) | Enable wrap + spell check |
| FileType (json, jsonc, json5) | Set conceallevel=0 |
| BufWritePre | Auto-create missing directories |
| FileType (bigfile) | Disable heavy features |
| FileType (all) | Enable treesitter highlight + indent |
| BufWritePre | Format on save (conform.nvim) |
| LspAttach | Register LSP keymaps |

---

## Colorschemes

**Primary:** `pinot_noir` — A modern noir theme. Pure black background, grayscale foreground palette, red accents for numbers/errors. Full treesitter + LSP highlight support.

**Alternatives (lazy-loaded):**
- `:colorscheme rose-pine`
- `:colorscheme gruvbox`
- `:colorscheme nord`

Switch with live preview: `<leader>sC`

---

## External Dependencies

| Tool | Required by | Install |
|------|-------------|---------|
| git | gitsigns, diffview, telescope | System package manager |
| ripgrep (rg) | telescope live_grep | `brew install ripgrep` |
| fd | telescope find_files | `brew install fd` |
| C compiler | telescope-fzf-native | Xcode CLT / gcc |
| dart / flutter SDK | flutter-tools, dartls | flutter.dev |
| stylua | conform (lua formatting) | `brew install stylua` |
| Python 3 (pyenv) | python3_host_prog | Already configured |
| Nerd Font | Icons everywhere | Already installed |
