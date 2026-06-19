# Neovim Configuration Reference

> Looking for a fast lookup? See the [Cheatsheet](/cheatsheet) for the
> most-used keymaps plus native Neovim tricks.

## Directory Structure

```
~/.config/nvim/
├── init.lua                          # Entry point (loads modules below)
├── doc/
│   ├── configuration.md              # This file
│   ├── cheatsheet.md                 # Quick reference + native tricks
│   └── flutter-guide.md              # Flutter development guide
└── lua/maths-lover/
    ├── options.lua                   # Editor settings, winborder, diagnostics
    ├── keymaps.lua                   # Core key mappings
    ├── autocmds.lua                  # Autocommands
    ├── neovide.lua                   # Neovide GUI settings (guarded)
    ├── git-terminal.lua              # Native floating lazygit terminal
    ├── lazy.lua                      # Plugin manager bootstrap
    └── plugins/
        ├── init.lua                  # Empty (specs in individual files)
        ├── treesitter.lua            # Syntax, textobjects, context, repeatable moves
        ├── which-key.lua             # Keymap discovery popup
        ├── telescope.lua             # Fuzzy finder (rg + fd)
        ├── project.lua               # project.nvim — multi-project root switching
        ├── yazi.lua                  # yazi.nvim — filesystem browser (replaces oil/netrw)
        ├── lsp.lua                   # LSP keymaps, inlay hints, doc highlight
        ├── completion.lua            # blink.cmp (1.x) + snippets
        ├── colorscheme.lua           # rose-pine (main = dark, dawn = light)
        ├── git.lua                   # gitsigns
        ├── conform.lua               # Auto-formatter
        ├── lualine.lua               # Statusline
        ├── python.lua                # basedpyright + ruff LSP
        └── go.lua                    # gopls LSP
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
| Statusline | Global (laststatus=3) | lualine with `globalstatus = true` |
| Showmode | Off | Lualine shows mode instead |
| Scrolloff | 10 lines | |
| Undo | Persistent (undofile) | |
| Whitespace | Visible | tabs=→, trail=·, eol=↵, lead=·, nbsp=␣ |
| **Float borders** | `winborder = 'rounded'` | Native 0.11 — all floats get rounded borders |
| **Diagnostics** | `vim.diagnostic.config` | Virtual text, severity sort, signs, bordered float |
| Bigfile | >1.5MB disables plugins | |

### Diagnostics display (native)

Configured once in `options.lua` via `vim.diagnostic.config`:

- **virtual_text** — inline messages (shown when there are several on a line)
- **severity_sort** — errors render above warnings/hints
- **signs** — nerd-font glyphs in the sign column, matching the lualine icons
- **float** — rounded border, shows the source when multiple

## Plugin Manager — lazy.nvim

- Auto-bootstraps on first launch
- Plugin specs loaded from `lua/maths-lover/plugins/`
- `:Lazy` to open the dashboard (install, update, clean, profile)
- `lazy-lock.json` pins exact versions

## Installed Plugins

| Plugin | Purpose | Load |
|--------|---------|------|
| nvim-treesitter | Parser management, highlighting, indentation | Eager |
| nvim-treesitter-textobjects | Syntax-aware text objects + repeatable moves | With treesitter |
| nvim-treesitter-context | Sticky function/class header (max 3 lines) | With treesitter |
| which-key.nvim | Keymap popup on partial input | VeryLazy |
| telescope.nvim | Fuzzy finder UI | VimEnter |
| telescope-fzf-native.nvim | Native fzf sorter (compiled C) | With telescope |
| telescope-ui-select.nvim | Replaces vim.ui.select | With telescope |
| **project.nvim** | Auto-detect project roots + recent-projects picker | VeryLazy |
| **yazi.nvim** | Filesystem browser (replaces oil + netrw) | VeryLazy |
| nvim-lspconfig | LSP server defaults (paired with native `vim.lsp.config`) | BufReadPre |
| flutter-tools.nvim | Dart/Flutter LSP + widget enhancements | ft=dart |
| blink.cmp (1.x) | Autocompletion + signature help | With lspconfig |
| friendly-snippets | VSCode-format snippet collection | With blink.cmp |
| rose-pine | Colorscheme (main = dark, dawn = light) | Eager, priority=1000 |
| gitsigns.nvim | Git signs in gutter, hunk operations, blame | BufReadPre |
| conform.nvim | Code formatter (format on save) | BufWritePre |
| lualine.nvim | Statusline | Eager |
| basedpyright | Python type checking + intellisense (via LSP) | ft=python |
| ruff | Python linting + code actions (via LSP) | ft=python |
| gopls | Go LSP server | ft=go |
| plenary.nvim | Lua utility library (dependency) | — |
| nvim-web-devicons | File icons (dependency) | — |

> **Git TUI is plugin-free.** lazygit runs in a native floating `:terminal`
> defined in `git-terminal.lua` — no `lazygit.nvim`. Merge conflicts are
> resolved in lazygit or with native `:diffget` / `:diffput`.

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

### Find / Files — `<leader>f`, `<leader>e`

File browsing (yazi) and project switching (project.nvim).

| Key | Mode | Action |
|-----|------|--------|
| `-` | n | Open yazi at the current file |
| `<leader>e` | n | Open yazi at the current file |
| `<leader>E` | n | Open yazi at the cwd |
| `<leader>fy` | n | Resume last yazi session |
| `<leader>fp` | n | Project picker (switch root) |

**Inside yazi:** `h` / `l` walk directories, `<CR>` opens, `<f1>` help.
Navigate to any path on disk and open files into the current session.

> **Multi-project workflow.** project.nvim auto-detects a root (`.git`,
> `go.mod`, `pyproject.toml`, `package.json`, `Makefile`, `Cargo.toml`, …)
> and sets the cwd to whichever project the focused buffer belongs to. So
> `<leader>sf` / `<leader>sg` always scope to the active project, and you can
> keep several projects open in one session. `<leader>fp` jumps between
> recent roots; yazi reaches files outside any project.

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
| `<C-/>` (insert) / `?` (normal) | Show this picker's mappings |

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
| `<leader>ch` | n | Toggle inlay hints | vim.lsp |
| `<leader>cf` | n | Format buffer | conform.nvim |
| `<leader>cd` | n | Diagnostics list (quickfix) | built-in |
| `<leader>cD` | n | Buffer diagnostics (quickfix) | built-in |

**Native LSP defaults (Neovim 0.11).** Core auto-maps these on every LSP
buffer — no config needed, available alongside the above:

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | References |
| `gri` | Implementation |
| `grt` | Type definition |
| `gO` | Document symbols |
| `<C-s>` (insert) | Signature help |

**Inlay hints** are enabled by default when the server supports them
(`vim.lsp.inlay_hint`); `<leader>ch` toggles them per buffer.

**Document highlight** — resting the cursor on a symbol highlights its other
uses in the buffer (LSP `documentHighlight`, cleared on move).

### Treesitter Text Objects & Motions

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
| `;` | n, x, o | **Repeat last move** (TS move or f/t/F/T) |
| `,` | n, x, o | **Repeat last move, opposite direction** |
| `f` / `F` / `t` / `T` | n, x, o | Find char (now repeatable with `;` / `,`) |

> After any `]m` / `]]` / `f` / `t` jump, hammer `;` and `,` to repeat it
> forward / backward. The TS move functions are auto-tracked.

### Hunk (Git) — `<leader>h` (gitsigns)

| Key | Mode | Action |
|-----|------|--------|
| `]c` / `[c` | n | Next/previous hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage entire buffer |
| `<leader>hR` | n | Reset entire buffer |
| `<leader>hp` | n | Preview hunk in float |
| `<leader>hb` | n | Blame current line (full) |
| `<leader>hB` | n | Toggle inline blame (virtual text) |
| `<leader>hd` | n | Diff this file |
| `<leader>hq` | n | Send all repo hunks to quickfix |
| `ih` | o, x | Select hunk (text object) |

### Git — `<leader>g` (native lazygit terminal)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Open lazygit (cwd) |
| `<leader>gG` | n | Open lazygit (current file's repo root) |
| `<leader>gl` | n | Lazygit log filtered to current file |

Lazygit launches in a native floating `:terminal` (`git-terminal.lua`). On
exit the float closes and gitsigns auto-refreshes so the gutter reflects the
new repo state. **Merge conflicts:** resolve in lazygit, or with native
`:diffget //2` (ours) / `:diffget //3` (theirs) during a `:Gdiff`-style merge.

### Diagnostics Navigation (built-in)

| Key | Mode | Action |
|-----|------|--------|
| `]d` / `[d` | n | Next/previous diagnostic |
| `]e` / `[e` | n | Next/previous error |
| `]w` / `[w` | n | Next/previous warning |
| `<leader>cd` | n | All diagnostics → quickfix |
| `<leader>cD` | n | Buffer diagnostics → quickfix |

### Completion (blink.cmp 1.x — `default` preset)

| Key | Mode | Action |
|-----|------|--------|
| `<C-space>` | i | Show completion / toggle docs |
| `<C-y>` | i | Accept selected item |
| `<C-e>` | i | Dismiss completion |
| `<C-n>` / `<C-p>` | i | Next / previous item |
| `<Up>` / `<Down>` | i | Next / previous item |
| `<C-b>` / `<C-f>` | i | Scroll documentation |
| `<C-k>` | i | Toggle signature help |
| `<Tab>` / `<S-Tab>` | i | Jump snippet placeholders |

Sources: `lsp`, `path`, `snippets`, `buffer`. Signature help is enabled.

### Theme

| Key | Mode | Action |
|-----|------|--------|
| `<leader>tt` | n | Toggle light (rose-pine-dawn) / dark (rose-pine-main) |

### Neovide (GUI only)

Active only under Neovide (`neovide.lua` is guarded by `vim.g.neovide`).

| Key | Mode | Action |
|-----|------|--------|
| `<D-s>` | n, i, v | Save file |
| `<D-c>` / `<D-v>` | v / multiple | Copy / paste via system clipboard |
| `<D-=>` / `<D-->` / `<D-0>` | n | Zoom in / out / reset |

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
| `:checkhealth vim.lsp` | LSP health overview (attached clients, capabilities) |

### Per-project overrides

If you want to override the resolver, drop a `pyrightconfig.json` (or
`[tool.pyright]` block in `pyproject.toml`) at the project root and set
`venvPath` / `venv` explicitly — basedpyright honors those over the
`pythonPath` setting we inject.

---

## Autocommands

| Event | Action |
|-------|--------|
| TextYankPost | Briefly highlight yanked text (`vim.hl.on_yank`) |
| VimResized | Auto-equalize split sizes |
| BufReadPost | Restore cursor position |
| FileType (help, qf, etc.) | Close with `q` |
| FileType (text, markdown, etc.) | Enable wrap + spell check |
| FileType (json, jsonc, json5) | Set conceallevel=0 |
| BufWritePre | Auto-create missing directories |
| FileType (bigfile) | Disable heavy features |
| FileType (all) | Enable treesitter highlight + indent |
| BufWritePre | Format on save (conform.nvim) |
| LspAttach | LSP keymaps, inlay hints, document highlight |

---

## Colorschemes

**Default (dark):** `rose-pine-main`
**Toggle:** `<leader>tt` flips between `rose-pine-main` (dark) and
`rose-pine-dawn` (light). Both ship with the same plugin, so the toggle is
instant. Comments are softened (`subtle`) and de-italicised for the
ComicCode font.

Browse all schemes with live preview: `<leader>sC`.

---

## External Dependencies

| Tool | Required by | Install |
|------|-------------|---------|
| git | gitsigns, telescope, project.nvim | System package manager |
| yazi (+ ya) | yazi.nvim file browser | `cargo install --force yazi-build` |
| lazygit | native git terminal (`<leader>gg`) | `brew install lazygit` / pkg manager |
| ripgrep (rg) | telescope live_grep | `brew install ripgrep` |
| fd | telescope find_files | `brew install fd` |
| C compiler | telescope-fzf-native | gcc / clang / Xcode CLT |
| dart / flutter SDK | flutter-tools, dartls | flutter.dev |
| go / gopls | go.lua LSP | go.dev |
| goimports | conform (go formatting) | `go install golang.org/x/tools/cmd/goimports@latest` |
| basedpyright | python.lua LSP | `uv tool install basedpyright` |
| ruff | python.lua linting + conform formatting | `uv tool install ruff` |
| stylua | conform (lua formatting) | `brew install stylua` |
| uv | Per-project venv + dependency resolution | astral.sh/uv |
| Python 3 (host) | python3_host_prog | uv-managed nvim-provider venv |
| Nerd Font | Icons everywhere | ComicCodeLigatures Nerd Font |
