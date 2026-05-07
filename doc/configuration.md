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
        ├── lsp.lua                    # LSP keymaps + flutter-tools
        ├── completion.lua             # blink.cmp + snippets
        ├── colorscheme.lua            # rose-pine (main + dawn variants) and alternates
        ├── git.lua                    # gitsigns + git-conflict
        ├── lazygit.lua                # lazygit floating TUI
        ├── oil.lua                    # File explorer
        ├── conform.lua                # Auto-formatter
        ├── lualine.lua                # Statusline
        ├── python.lua                 # basedpyright + ruff LSP
        └── go.lua                     # gopls LSP
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
| Statusline | laststatus=2 | Default (lualine renders in Neovim) |
| Cmdheight | 1 | Default; needed for `:!cmd` output visibility |
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
| rose-pine | Primary colorscheme (main = dark, dawn = light) | Eager, priority=1000 |
| pinot_noir.nvim | Colorscheme (local, noir style) | Lazy |
| colorbuddy.nvim | Colorscheme helper (pinot_noir dependency) | With pinot_noir |
| nord.nvim | Colorscheme (alternative) | Lazy |
| gitsigns.nvim | Git signs in gutter, hunk operations | BufReadPre |
| git-conflict.nvim | Merge conflict resolution helpers | BufReadPre |
| lazygit.nvim | Floating-window lazygit TUI | On command/key |
| oil.nvim | File explorer (edit filesystem as buffer) | Eager |
| conform.nvim | Code formatter (format on save) | BufWritePre |
| lualine.nvim | Statusline | Eager |
| basedpyright | Python type checking + intellisense (via LSP) | ft=python |
| ruff | Python linting + code actions (via LSP) | ft=python |
| gopls | Go LSP server | ft=go |
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
| `<leader>cl` | n | Line diagnostics (float) | vim.diagnostic |
| `<leader>cs` | n | Document symbols | Telescope |
| `<leader>cS` | n | Workspace symbols | Telescope |
| `<leader>ct` | n | Type definition | Telescope |
| `<leader>cf` | n | Format buffer | conform.nvim |
| `<leader>cd` | n | Diagnostics list (quickfix) | built-in |
| `<leader>cD` | n | Buffer diagnostics (quickfix) | built-in |

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

### Git — `<leader>g` (lazygit)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Open lazygit (cwd) |
| `<leader>gG` | n | Open lazygit (current file's repo) |
| `<leader>gl` | n | Lazygit log filtered to current file |

Lazygit launches in a floating window. On exit, gitsigns auto-refreshes
so the gutter reflects the new repo state.

### Merge Conflict — `<leader>mc` (git-conflict.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `]x` / `[x` | n | Next/previous conflict |
| `<leader>mco` | n | Choose ours |
| `<leader>mct` | n | Choose theirs |
| `<leader>mcb` | n | Choose both |
| `<leader>mcn` | n | Choose none |
| `<leader>mcl` | n | List conflicts in quickfix |

> Full-tree git workflows (status, log, diff, stage, commit) are handled outside Neovim via lazygit.

### Diagnostics Navigation (built-in)

| Key | Mode | Action |
|-----|------|--------|
| `]d` / `[d` | n | Next/previous diagnostic |
| `]e` / `[e` | n | Next/previous error |
| `]w` / `[w` | n | Next/previous warning |
| `<leader>cd` | n | All diagnostics → quickfix |
| `<leader>cD` | n | Buffer diagnostics → quickfix |

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

## Python projects (uv / venv)

`plugins/python.lua` resolves a per-project Python interpreter and feeds
it to both basedpyright (`python.pythonPath`) and ruff
(`init_options.settings.interpreter`). This is what makes type checking
and lint diagnostics see installed dependencies.

### Resolution order

When the LSP starts for a Python buffer, the resolver picks the first
match it finds:

1. **`$VIRTUAL_ENV`** — an already-activated venv wins.
2. **`<root>/.venv/bin/python`** — uv default; also `python -m venv .venv`.
3. **`<root>/venv/bin/python`** — common alternative layout.
4. System `python3` as a final fallback.

The search is upward-walking, so opening a file deep in a uv project
still finds the `.venv` at the repo root.

### Typical uv workflow

```sh
uv init my-project && cd my-project
uv add requests pydantic         # creates .venv automatically
nvim main.py                     # basedpyright + ruff resolve to .venv
```

You don't need to activate the venv — opening nvim from anywhere inside
the project tree is enough.

### Inspecting the picked interpreter

| Command | Purpose |
|---------|---------|
| `:PyInfo` | Print the resolved interpreter and which source picked it (`VIRTUAL_ENV`, `.venv`, `venv`, `system`) |
| `:LspInfo` | Show attached LSP clients for the buffer |
| `:checkhealth vim.lsp` | LSP health overview |

### Per-project overrides

If you want to override the resolver, drop a `pyrightconfig.json` (or
`[tool.pyright]` block in `pyproject.toml`) at the project root and set
`venvPath` / `venv` explicitly — basedpyright honors those over the
`pythonPath` setting we inject.

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

**Default (dark):** `rose-pine-main`
**Toggle:** `<leader>tt` flips between `rose-pine-main` (dark) and `rose-pine-dawn` (light). Both ship with the same plugin, so the toggle is instant.

**Alternatives (lazy-loaded):**
- `:colorscheme pinot_noir` (local plugin, noir style)
- `:colorscheme nord`

Switch with live preview: `<leader>sC`

---

## External Dependencies

| Tool | Required by | Install |
|------|-------------|---------|
| git | gitsigns, git-conflict, telescope | System package manager |
| lazygit | lazygit.nvim TUI | `brew install lazygit` |
| ripgrep (rg) | telescope live_grep | `brew install ripgrep` |
| fd | telescope find_files | `brew install fd` |
| C compiler | telescope-fzf-native | Xcode CLT / gcc |
| dart / flutter SDK | flutter-tools, dartls | flutter.dev |
| go / gopls | go.lua LSP | go.dev |
| goimports | conform (go formatting) | `go install golang.org/x/tools/cmd/goimports@latest` |
| basedpyright | python.lua LSP | `uv tool install basedpyright` |
| ruff | python.lua linting + conform formatting | `uv tool install ruff` |
| stylua | conform (lua formatting) | `brew install stylua` |
| uv | Per-project venv + dependency resolution | `brew install uv` |
| Python 3 (host) | python3_host_prog | uv-managed nvim-provider venv |
| Nerd Font | Icons everywhere | Already installed |
