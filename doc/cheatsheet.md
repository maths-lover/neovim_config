# Cheatsheet

Fast lookup for daily driving, plus native Neovim tricks worth building into
muscle memory. Leader is `<Space>`. For the exhaustive list see the
[Configuration Reference](/configuration).

## Daily drivers (this config)

| Key | Action |
|-----|--------|
| `<leader>sf` | Find files (active project) |
| `<leader>sg` | Live grep (active project) |
| `<leader>sw` | Grep word under cursor |
| `<leader>sb` | Switch buffer |
| `<leader>s.` | Recent files |
| `<leader>sr` | Resume last picker |
| `-` / `<leader>e` | yazi at current file |
| `<leader>E` | yazi at cwd |
| `<leader>fp` | Switch project root |
| `<leader>gg` | lazygit (cwd) |
| `gd` / `gr` | Definition / references |
| `K` | Hover docs |
| `<leader>ca` / `<leader>cr` | Code action / rename |
| `<leader>cf` | Format buffer |
| `<leader>ch` | Toggle inlay hints |
| `[d` `]d` / `[e` `]e` | Prev/next diagnostic / error |
| `]c` `[c` | Next/prev git hunk |
| `<leader>hp` `<leader>hs` `<leader>hr` | Preview / stage / reset hunk |
| `]m` `[m` / `]]` `[[` | Next/prev function / class |
| `;` `,` | Repeat last move (TS or f/t) fwd/back |
| `<leader>tt` | Toggle light/dark theme |
| `<leader>?` | Show all keymaps (which-key) |

---

## Native Neovim tricks & tips

Everything below is **built-in vim/Neovim** — no plugins. This is where the
biggest speedups live.

### The grammar: operator + count + motion/text-object

Vim editing is a language. Learn the pieces and they combine:

```
[count] operator [count] motion-or-textobject
   2       d              j          → delete 2 lines down
           c              i"         → change inside quotes
           >              ip         → indent inner paragraph
           y              a{         → yank a block incl. braces
```

**Operators:** `d` delete · `c` change · `y` yank · `>` `<` indent · `=` reindent · `gu`/`gU`/`g~` case · `gq` format/wrap · `!` filter through shell cmd

**Text objects** (`i`=inner, `a`=around): `w` word · `W` WORD · `s` sentence · `p` paragraph · `"` `'` `` ` `` quotes · `(` `)` `b` parens · `{` `}` `B` braces · `[` `]` brackets · `<` `>` tags-of-angle · `t` HTML tag
Plus this config's TS objects: `if`/`af` function · `ic`/`ac` class · `ia`/`aa` parameter.

> Examples: `ci(` change inside parens · `dat` delete a tag · `ya"` yank a quoted string · `vip` select paragraph · `>i{` indent a block · `gUiw` uppercase a word.

### Repetition — the force multipliers

| Key | Does |
|-----|------|
| `.` | Repeat last change (the single most valuable key) |
| `;` / `,` | Repeat last `f`/`t` find forward / back (here: also TS moves) |
| `n` / `N` | Repeat last search forward / back |
| `&` | Repeat last `:s` substitution on current line |
| `@:` | Repeat last `:` ex command |
| `@@` | Repeat last macro |

> Workflow: make a precise change with a text object (`ciw…<Esc>`), then `n.`
> `n.` `n.` to ripple it across matches. Edit one, repeat many.

### Macros

```
qa            start recording into register a
…             do your edits (make them repeatable!)
q             stop recording
@a            play macro a
3@a           play it 3 times
@@            replay the last macro
```

Apply a macro to many lines at once: visually select, then `:normal @a`.
Macros are just register contents — `:let @a='...'` edits one, `"ap` pastes it.

### Registers (named clipboards)

| Register | Holds |
|----------|-------|
| `"ay` `"ap` | Yank into / paste from register `a` |
| `"0` | Last **yank** (survives deletes) |
| `"+` / `"*` | System clipboard |
| `".` | Last inserted text |
| `":` | Last command |
| `"/` | Last search |
| `"%` | Current filename |
| `<C-r>a` (insert) | Paste register `a` while typing |
| `<C-r>"` (insert/cmdline) | Paste the unnamed register |

> `"0p` after deleting something pastes what you *yanked*, not what you just
> deleted — fixes the classic "my yank got clobbered" problem.

### Search & replace power

| Command | Effect |
|---------|--------|
| `*` / `#` | Search word under cursor forward / back |
| `g*` / `g#` | Same, but partial (not whole-word) |
| `:%s/foo/bar/g` | Replace all in file |
| `:%s/foo/bar/gc` | …with confirm on each |
| `:s/foo/bar/` | Replace on current line |
| `:'<,'>s/…/…/` | Replace in visual selection |
| `:%s/\<word\>//g` | Whole-word match with `\<` `\>` |
| `:&&` | Repeat last substitute with same flags |

> `inccommand=split` is enabled here, so `:%s/…/…/` shows a live preview in a
> split as you type — you see every match change before you press Enter.

**`:g` (global) — operate on matching lines:**

```
:g/TODO/d                 delete every line containing TODO
:g/pattern/normal A;      append ; to every matching line
:g/^$/d                   delete blank lines
:v/keep/d                 delete lines NOT matching (inverse)
:g/foo/t$                 copy matching lines to end of file
```

**`:normal` — run normal-mode commands over a range:**

```
:%normal A;               append ; to every line
:'<,'>normal Iprefix      prepend "prefix" to selected lines
```

**`:sort` — reorder lines natively (cleaner than `:%!sort`):**

```
:sort                     sort the whole buffer (or a given range)
:'<,'>sort                sort only the visual selection
:sort u                   sort and drop duplicate lines
:sort n                   numeric sort (by first number on each line)
:sort i                   case-insensitive sort
:sort /pattern/           sort by what follows the matched pattern
```

### Motions you should be using

| Motion | Jumps to |
|--------|----------|
| `w` `b` `e` `ge` | word boundaries (`W`/`B`/`E` = WORD) |
| `0` `^` `$` | line start / first non-blank / end |
| `f{c}` `t{c}` | onto / before next char `c` (`F`/`T` backward) |
| `{` `}` | previous / next paragraph |
| `(` `)` | previous / next sentence |
| `%` | matching pair `()[]{}` (and more via matchit) |
| `H` `M` `L` | top / middle / bottom of screen |
| `gg` `G` | top / bottom of file (`{n}G` = line n) |
| `` `` `` (backtick backtick) | jump to position before the last jump |
| `g;` `g,` | older / newer position in **changelist** |
| `gi` | jump to last insert and resume Insert |
| `gd` `gD` | definition / declaration — **LSP here** (text-based only without an LSP) |
| `zz` `zt` `zb` | center / top / bottom the current line on screen |
| `<C-o>` `<C-i>` | jump back / forward in the **jumplist** |
| `Ctrl-d` `Ctrl-u` | half-page down / up |

> In this config `j`/`k` are remapped to `gj`/`gk`, so they already step by
> *display* line — moving through wrapped/long lines just works.

### Marks

| Key | Action |
|-----|--------|
| `ma` | Set mark `a` (lowercase = file-local, uppercase = global across files) |
| `` `a `` | Jump to exact mark position; `'a` to its line |
| `` `. `` | Jump to last change |
| `` `^ `` | Jump to last insert position |
| `:marks` | List all marks |

### Visual mode tricks

| Key | Action |
|-----|--------|
| `v` `V` `<C-v>` | charwise / linewise / **blockwise** visual |
| `gv` | Reselect last visual selection |
| `o` | Jump to other end of selection |
| `<C-v>` then `I`/`A` then `<Esc>` | Insert/append on every line of a block |
| `:'<,'>` | Range pre-filled for ex commands on selection |
| `gq` | Reflow/wrap selected text to `textwidth` |
| `=` | Auto-indent selection |
| `u` / `U` | Lowercase / uppercase selection |

### Numbers, increments, formatting

| Key | Action |
|-----|--------|
| `<C-a>` / `<C-x>` | Increment / decrement number under cursor |
| `g<C-a>` (visual) | Make a column of incrementing numbers |
| `gq` / `gqq` | Format motion / line to textwidth |
| `gw` | Like `gq` but keep cursor put |
| `==` | Reindent current line |

### Folds (Treesitter-based here)

| Key | Action |
|-----|--------|
| `za` | Toggle fold under cursor |
| `zR` / `zM` | Open all / close all folds |
| `zo` / `zc` | Open / close one fold |
| `zj` / `zk` | Move to next / previous fold |

### Spelling

`spell` is auto-enabled here for text/markdown filetypes (see `autocmds.lua`), so
these are live whenever you write prose or docs:

| Key | Action |
|-----|--------|
| `]s` / `[s` | Next / previous misspelled word |
| `z=` | Suggest corrections for the word under the cursor |
| `zg` / `zw` | Add to dictionary as good / mark as wrong |
| `zug` / `zuw` | Undo a `zg` / `zw` for the word |
| `<C-x><C-k>` (insert) | Complete from the spell dictionary |
| `:set spell!` | Toggle spell manually |

### Windows, tabs, buffers

| Key | Action |
|-----|--------|
| `<C-w>s` / `<C-w>v` | Split horizontal / vertical |
| `<C-w>w` / `<C-w>q` | Cycle / close window |
| `<C-w>o` | Close all other windows |
| `<C-w>=` | Equalize sizes |
| `<C-w>T` | Move window to its own tab |
| `gt` / `gT` | Next / previous tab |
| `<C-^>` | Toggle to the alternate (previous) buffer |
| `:b {name}` | Jump to buffer by partial name (Tab-completes) |

### Diff mode (native — pairs with git-conflict.nvim)

| Command / key | Action |
|---------------|--------|
| `:diffthis` | Mark the current window for diffing (run in 2+ windows) |
| `:diffsplit {file}` | Open `{file}` in a split and diff against it |
| `:windo diffthis` / `:diffoff!` | Diff / un-diff all windows |
| `]c` / `[c` | Next / previous change *(inside a diff)* |
| `do` / `dp` | Diff **obtain** (pull other side in) / **put** (push out) |

> Heads-up on `]c` `[c`: in normal buffers these are git hunks (gitsigns); inside
> a `:diffthis` they navigate diff changes. Same keys, context-dependent.

### Quickfix & location list

The quickfix list is the backbone of project-wide edits.

| Command | Action |
|---------|--------|
| `:copen` / `:cclose` | Open / close quickfix window |
| `:cnext` `:cprev` | Next / previous entry |
| `:cdo {cmd}` | Run `{cmd}` on every quickfix entry |
| `:cfdo {cmd}` | Run `{cmd}` once per file in the list |
| `:ldo` / `:lopen` | Same for the location list (window-local) |

**Populate it without any plugin:**

| Command | Action |
|---------|--------|
| `:vimgrep /pat/ **/*.lua` | Native recursive search → quickfix (zero config) |
| `:grep {pat}` | Search via `grepprg` → quickfix (set `grepprg=rg\ --vimgrep`) |
| `:args **/*.lua` → `:argdo {cmd}` | Run `{cmd}` over the arglist, e.g. `:argdo %s/old/new/ge \| update` |

> **Multi-file refactor:** in any Telescope picker, multi-select with `<Tab>`
> then `<C-q>` to send results to quickfix → `:cdo s/old/new/g | update`.

### Command-line & insert-mode gems

| Key | Action |
|-----|--------|
| `q:` | Open command-line **history window** (edit & re-run commands as text) |
| `q/` | Search history window |
| `<C-r><C-w>` (cmdline) | Insert the word under cursor into the command line |
| `<C-r>%` (cmdline) | Insert current filename |
| `<C-o>` (insert) | Run one normal-mode command, then back to insert |
| `<C-w>` / `<C-u>` (insert) | Delete previous word / to line start |
| `<C-t>` / `<C-d>` (insert) | Indent / dedent current line |

### Native insert-mode completion (`<C-x>` submode)

Even with blink.cmp driving the popup, these native sources work in any buffer
with no setup — `<C-x><C-f>` for file paths is the standout:

| Key (insert) | Completes |
|--------------|-----------|
| `<C-x><C-f>` | **File paths** (relative to cwd) |
| `<C-x><C-l>` | Whole lines from open buffers |
| `<C-x><C-o>` | Omni completion (LSP-backed when attached) |
| `<C-x><C-n>` / `<C-x><C-p>` | Keywords from the current buffer |
| `<C-x><C-]>` | Tags |
| `<C-n>` / `<C-p>` | Generic keyword completion (next / prev) |

### Files & the outside world

| Command | Action |
|---------|--------|
| `gx` | Open URL / file under cursor in the OS (via `vim.ui.open`) |
| `gf` | Go to file under cursor |
| `:e %:h/` | Edit relative to current file's directory |
| `:r !cmd` | Read shell command output into the buffer |
| `:%!cmd` | Filter the whole buffer through a shell command (e.g. `:%!jq .`) |
| `!ip{cmd}` | Filter a text object through a shell command |
| `:earlier 5m` / `:later` | Time-travel through undo history |
| `g-` / `g+` | Step through undo *states* (not just the linear chain) |

### Inspect & introspect (Neovim natives)

| Command | Action |
|---------|--------|
| `:Inspect` | Show highlight + Treesitter + extmark groups under the cursor |
| `:InspectTree` | Live Treesitter syntax tree of the buffer |
| `:checkhealth` | Diagnose config / plugins / providers |
| `:Tutor` | The built-in interactive vim tutor |
| `:h {topic}` | Help (here: `<leader>sh` for a fuzzy help picker) |
| `:verbose map <key>` | Find what mapped a key and where |
| `:messages` | Re-show notifications/errors that scrolled past |

### LSP & diagnostics (native, no extra mappings)

- `[d` / `]d` walk diagnostics; `<leader>cl` shows the line's float.
- `grn` rename, `gra` code action, `grr` refs, `gri` impl, `grt` type-def,
  `gO` document symbols — all native Neovim 0.11 LSP defaults.
- `<C-]>` / `<C-t>` — jump to tag / pop the tag stack (works with LSP too).
- `K` hover; `<C-s>` (insert) signature help.

---

## Practice drills

Pick one per week until it's automatic:

1. **Ban the arrow keys & `hjkl`-spam.** Cross functions with `]m` / `[m`,
   then `;` / `,`. Jump in-line with `f` / `t`, not repeated `l`.
2. **Live on text objects.** Never select a word by hand again — `ciw`, `ci"`,
   `dap`, `ya{`, `>i{`. Then `.` to repeat.
3. **Search-then-edit.** `*` to find a symbol, `cgn` to change the next match,
   then `.` `.` to sweep the rest. (`cgn` = change next search match.)
4. **Macros for the irregular stuff** that `:s` can't express cleanly.
5. **Quickfix refactors.** Telescope grep → `<C-q>` → `:cdo s/…/…/ | update`.
6. **`q:` instead of arrow-up** when reworking a command.

> Run `:Tutor` once end-to-end even now — most people skipped chapters the
> first time and the muscle memory pays back daily.
