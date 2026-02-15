# Flutter Development with Neovim — Complete Guide

This guide covers how to use this Neovim configuration for day-to-day Flutter/Dart development. The config provides full LSP intelligence, completion, formatting, and navigation — while building, running, testing, and debugging are done via CLI tools.

---

## Prerequisites

Before starting, ensure these are installed and in your PATH:

```bash
# Flutter SDK (includes Dart SDK and dartls language server)
flutter doctor

# Verify dart is accessible
dart --version

# Verify CLI tools used by telescope
which rg fd

# Verify formatter
which stylua
```

---

## 1. Opening a Flutter Project

```bash
cd ~/Develop/my_flutter_app
nvim .
```

This opens oil.nvim showing your project root. Press `<CR>` on `lib/` to enter it, then `<CR>` on `main.dart` to open it. Or use Telescope right away:

```
<leader>sf    → type "main.dart" → <CR>
```

When you open a `.dart` file, the following happens automatically:
1. **Treesitter** activates Dart syntax highlighting and indentation
2. **flutter-tools.nvim** starts the Dart analysis server (dartls)
3. **blink.cmp** connects to dartls for completions
4. **conform.nvim** registers `dart_format` for format-on-save
5. **Widget closing labels** appear as virtual text (e.g., `// Column`, `// Scaffold`)
6. **Widget guides** show indentation lines for the widget tree

You'll see a brief notification in the statusline when dartls finishes analyzing.

---

## 2. Navigating the Codebase

### Finding Files

| Action | Keys | Notes |
|--------|------|-------|
| Find any file | `<leader>sf` | Uses fd, respects .gitignore |
| Recent files | `<leader>s.` | Files you've opened before |
| Open buffers | `<leader>sb` | Switch between open files |
| File explorer | `-` | Opens oil in current file's directory |

### Searching Code

| Action | Keys | Notes |
|--------|------|-------|
| Grep across project | `<leader>sg` | Live grep with ripgrep |
| Grep word under cursor | `<leader>sw` | Quick search for the current symbol |
| Search in current file | `<leader>s/` | Fuzzy find in buffer |
| Search TODOs | `<leader>sT` | All TODO/FIXME/HACK comments |

### Jumping to Definitions

| Action | Keys | Notes |
|--------|------|-------|
| Go to definition | `gd` | Jump to where a class/function is defined |
| Go to references | `gr` | See everywhere a symbol is used |
| Go to implementation | `gi` | Jump to implementation of an interface |
| Go to declaration | `gD` | Go to declaration |
| Type definition | `<leader>cD` | Jump to the type's definition |
| Document symbols | `<leader>cs` | Browse all symbols in current file |
| Workspace symbols | `<leader>cS` | Search symbols across entire project |
| Treesitter symbols | `<leader>st` | Functions/classes in current file |

### Moving Within a File

| Action | Keys |
|--------|------|
| Next/previous function | `]m` / `[m` |
| Next/previous class | `]]` / `[[` |
| Function end | `]M` / `[M` |
| Class end | `][` / `[]` |

---

## 3. Writing Dart Code

### Autocompletion

Start typing and the completion menu appears automatically. The menu shows:
- **LSP completions** — classes, methods, properties, imports
- **Snippets** — pre-made templates (see below)
- **Path completions** — file paths in strings
- **Buffer words** — words from the current buffer

| Action | Keys |
|--------|------|
| Trigger completion manually | `<C-space>` |
| Accept suggestion | `<C-y>` |
| Next/previous item | `<C-n>` / `<C-p>` |
| Dismiss menu | `<C-e>` |
| Scroll docs | `<C-f>` / `<C-b>` |

When you accept a function, `completeFunctionCalls` is enabled so parameters are auto-inserted. Use `<Tab>` / `<S-Tab>` to jump between snippet placeholders.

### Useful Dart/Flutter Snippets

Type these and accept with `<C-y>`:

| Trigger | Expands To |
|---------|-----------|
| `stless` | StatelessWidget boilerplate |
| `stful` | StatefulWidget boilerplate |
| `stanim` | StatefulWidget with AnimationController |
| `stprov` | StatefulWidget with Provider |
| `initS` | initState() override |
| `dis` | dispose() override |
| `build` | build() method |
| `debugP` | debugPrint() call |
| `toStr` | toString() override |
| `nosm` | noSuchMethod() override |

After accepting a snippet, press `<Tab>` to jump between placeholders (class name, body, etc.) and `<S-Tab>` to go back.

### Hover & Documentation

| Action | Keys | Notes |
|--------|------|-------|
| Hover docs | `K` | Shows type info, documentation, parameter details |
| Signature help | (auto) | Appears when typing function arguments |

Press `K` on any symbol to see its documentation. Press `K` again to enter the hover window and scroll through longer docs.

### Code Actions & Refactoring

| Action | Keys |
|--------|------|
| Code action | `<leader>ca` |
| Rename symbol | `<leader>cr` |

`<leader>ca` is one of the most powerful tools in Flutter development. Position your cursor and it offers context-sensitive actions:

**On a widget:**
- Wrap with Widget (Column, Row, Container, Padding, etc.)
- Wrap with Builder
- Extract Widget
- Extract Method
- Remove this widget

**On an import:**
- Organize imports
- Remove unused imports

**On an error/warning:**
- Quick fix suggestions
- Add missing import
- Create class/method
- Add required parameter
- Add `const` keyword

**On a variable/function:**
- Extract to variable/method/widget
- Inline variable
- Convert to expression body / block body
- Add type annotation

In visual mode, select a block of code then `<leader>ca` to extract it as a widget or method.

### Diagnostics

| Action | Keys |
|--------|------|
| Line diagnostics (float) | `<leader>cd` |
| All diagnostics (telescope) | `<leader>sd` |

Errors and warnings appear:
- In the **sign column** (left gutter) with colored icons
- As **virtual text** at the end of the line
- In the **statusline** (lualine diagnostics component)

Navigate between diagnostics using the built-in `[d` / `]d` (Neovim default) or search all with `<leader>sd`.

---

## 4. Formatting

### Automatic (on save)

Every time you save a `.dart` file (`:w`), `dart_format` runs automatically. This:
- Applies official Dart formatting rules
- Fixes indentation
- Wraps long lines (default 80 chars, configured in dartls settings)
- Organizes trailing commas

### Manual

| Action | Keys |
|--------|------|
| Format current buffer | `<leader>cf` |

If `dart_format` is not available, conform.nvim falls back to LSP formatting (dartls).

### Checking active formatter

Run `:ConformInfo` to see which formatter is active for the current buffer.

---

## 5. Working with the Widget Tree

Flutter-tools.nvim provides visual enhancements specific to Flutter:

### Closing Labels

When you write nested widgets, virtual text appears at the closing parenthesis showing which widget it belongs to:

```dart
Scaffold(
  body: Column(
    children: [
      Text('Hello'),
      ElevatedButton(
        onPressed: () {},
        child: Text('Press'),
      ),                           // ElevatedButton
    ],
  ),                               // Column
)                                  // Scaffold
```

### Widget Guides

Vertical guide lines appear connecting the widget constructor to its closing parenthesis, helping you see the hierarchy.

### Color Previews

When dartls detects a color value (e.g., `Colors.blue`, `Color(0xFF42A5F5)`), a virtual text color swatch appears.

---

## 6. Text Objects for Dart

Treesitter text objects make structural editing fast:

### Selecting Code Blocks

| Action | Keys | Example |
|--------|------|---------|
| Select entire function | `vaf` | Select a method including signature |
| Select function body | `vif` | Select just the body |
| Select entire class | `vac` | Select full class definition |
| Select class body | `vic` | Select just the class body |
| Select parameter | `via` | Select a single function parameter |
| Select parameter with comma | `vaa` | Includes surrounding comma |

### Operating on Functions

| Action | Keys | Example |
|--------|------|---------|
| Delete a function | `daf` | Deletes entire method |
| Yank a function | `yaf` | Copies entire method |
| Change function body | `cif` | Clears body, enters insert mode |
| Delete a parameter | `daa` | Removes parameter + comma |

### Swapping Parameters

Position your cursor on a parameter:

| Action | Keys |
|--------|------|
| Swap with next parameter | `<leader>a` |
| Swap with previous parameter | `<leader>A` |

Example: In `void foo(int a, String b, bool c)`, placing the cursor on `String b` and pressing `<leader>a` swaps it with `bool c`.

---

## 7. Git Workflow

### Viewing Changes While Coding

Gitsigns shows colored markers in the sign column:
- **Green bar** — Added lines
- **Blue bar** — Changed lines
- **Red triangle** — Deleted lines

### Hunk Operations

Navigate between changes:
- `]c` — Jump to next changed hunk
- `[c` — Jump to previous changed hunk

Stage or discard changes granularly:

| Action | Keys |
|--------|------|
| Preview hunk | `<leader>hp` |
| Stage hunk | `<leader>hs` |
| Reset (discard) hunk | `<leader>hr` |
| Stage entire file | `<leader>hS` |
| Reset entire file | `<leader>hR` |
| Blame current line | `<leader>hb` |

In **visual mode**, select specific lines then `<leader>hs` to stage just those lines.

### Reviewing Changes

| Action | Keys |
|--------|------|
| View all diffs | `<leader>gd` |
| View current file history | `<leader>gh` |
| Close diff view | `<leader>gq` |

`<leader>gd` opens a full-screen tab with:
- Left panel: list of changed files
- Right panels: side-by-side diff

Navigate between files with `<tab>` / `<s-tab>`. Stage files with `s`, unstage with `-`.

### Git via Telescope

| Action | Keys |
|--------|------|
| Browse commits | `<leader>sc` |
| View changed files | `<leader>ss` |

---

## 8. File Management with Oil

Press `-` from any file to open its directory in oil.nvim. This is a normal Neovim buffer where you can:

### Common Operations

| Task | How |
|------|-----|
| Navigate into directory | `<CR>` on directory name |
| Go to parent | `-` |
| Open file | `<CR>` on filename |
| Open in split | `<C-s>` (vertical) or `<C-h>` (horizontal) |
| Show hidden files | `g.` |

### File Operations (edit then `:w`)

| Task | How |
|------|-----|
| **Rename** | Edit the filename text, then `:w` |
| **Delete** | Delete the line (`dd`), then `:w` |
| **Create file** | Add a new line with the filename, then `:w` |
| **Create directory** | Add a new line ending with `/`, then `:w` |
| **Move** | Cut a line, paste in another oil buffer, then `:w` |

All changes are batched — nothing happens until you save. Oil shows a confirmation prompt before executing destructive operations. Deleted files go to trash.

### Typical Flutter File Operations

Create a new widget file:
1. Press `-` to open the `lib/` directory
2. Navigate to the right subdirectory
3. Press `o` to add a new line
4. Type `my_new_widget.dart`
5. Press `<Esc>` then `:w`
6. Press `<CR>` on the new file to open it

---

## 9. TODO Tracking

Write structured comments in your Dart code:

```dart
// TODO: implement error handling for network failures
// FIXME: this widget rebuilds too often
// HACK: workaround for Flutter issue #12345
// NOTE: this API requires authentication
// WARN: deprecated in Flutter 4.0
```

These are highlighted with distinct colors. Navigate with:
- `]t` — next TODO
- `[t` — previous TODO
- `<leader>sT` — search all TODOs in Telescope

---

## 10. CLI Companion Commands

These commands are run in a separate terminal (or Neovim's `:terminal`):

### Running

```bash
# Run on connected device / emulator
flutter run

# Run with specific device
flutter run -d chrome
flutter run -d emulator-5554

# Run in release mode
flutter run --release

# Run in profile mode (performance)
flutter run --profile
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

### Building

```bash
# Android APK
flutter build apk
flutter build apk --release

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
flutter build ipa

# Web
flutter build web

# macOS
flutter build macos
```

### Code Generation & Analysis

```bash
# Analyze code (same checks as dartls in editor)
flutter analyze

# Auto-fix lint issues
dart fix --apply

# Generate code (build_runner)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs
```

### Dependencies

```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Add a package
flutter pub add provider
flutter pub add --dev mockito

# Remove a package
flutter pub remove provider

# Check outdated packages
flutter pub outdated
```

### Useful Dart Commands

```bash
# Format (same as what runs on save in Neovim)
dart format .

# Format with custom line length
dart format -l 120 .

# Create a new project
flutter create my_app
flutter create --template=package my_package
flutter create --template=plugin my_plugin
```

---

## 11. Workflow Cheat Sheet

### Starting a Coding Session

1. `cd ~/project && nvim .`
2. `<leader>sf` to find the file you want to work on
3. Start coding — LSP, completion, and formatting are all automatic

### Making a Change

1. Navigate to code: `<leader>sg` to grep, or `gd` to follow a definition
2. Edit the code — completion with `<C-y>`, snippets with `<Tab>`
3. Check for errors: `<leader>cd` for current line, `<leader>sd` for all
4. Use code actions: `<leader>ca` to wrap widgets, extract methods, fix imports
5. Save: `:w` (auto-formats)

### Reviewing Before Commit

1. `]c` / `[c` to walk through changes
2. `<leader>hp` to preview each hunk
3. `<leader>gd` for full diff view
4. `<leader>hs` to stage hunks you want
5. Switch to terminal and commit

### Refactoring a Widget

1. Place cursor on the widget
2. `<leader>ca` → "Extract Widget" or "Extract Method"
3. Give it a name
4. `<leader>cr` to rename if needed
5. `gr` to verify all references updated
6. `:w` to auto-format

### Debugging an Issue

1. `<leader>sd` to see all diagnostics
2. `gd` to jump to the problematic definition
3. `K` to read documentation
4. `gr` to see all usages
5. `<leader>hb` to check who last changed this line
6. `<leader>gh` to view file history
