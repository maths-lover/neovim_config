# Flutter Development with Neovim — Complete Guide

This guide covers Flutter/Dart-specific workflows in this Neovim configuration. For the complete keymap reference, plugin list, and general settings, see [configuration.md](configuration.md).

---

## Prerequisites

```bash
flutter doctor        # Flutter SDK (includes Dart SDK and dartls)
dart --version        # Verify dart is accessible
which rg fd stylua    # CLI tools used by telescope and conform
```

---

## 1. Opening a Flutter Project

```bash
cd ~/Develop/my_flutter_app
nvim .
```

This opens oil.nvim showing your project root. Use `<leader>sf` to find files or navigate with oil (`<CR>` to enter directories).

When you open a `.dart` file, the following happens automatically:
1. **Treesitter** activates Dart syntax highlighting and indentation
2. **flutter-tools.nvim** starts the Dart analysis server (dartls)
3. **blink.cmp** connects to dartls for completions
4. **conform.nvim** registers `dart_format` for format-on-save
5. **Widget closing labels** appear as virtual text (e.g., `// Column`, `// Scaffold`)
6. **Widget guides** show indentation lines for the widget tree

---

## 2. Writing Dart Code

### Dart/Flutter Snippets

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

After accepting a snippet, press `<Tab>` to jump between placeholders and `<S-Tab>` to go back.

### Flutter Code Actions

`<leader>ca` offers Flutter-specific context-sensitive actions:

**On a widget:**
- Wrap with Widget (Column, Row, Container, Padding, etc.)
- Wrap with Builder
- Extract Widget / Extract Method
- Remove this widget

**On an import:**
- Organize imports / Remove unused imports

**On an error/warning:**
- Quick fix suggestions, add missing import, create class/method
- Add required parameter, add `const` keyword

**On a variable/function:**
- Extract to variable/method/widget
- Inline variable, convert to expression body / block body
- Add type annotation

In visual mode, select code then `<leader>ca` to extract it as a widget or method.

### Dart Formatting

Every time you save a `.dart` file (`:w`), `dart_format` runs automatically — applies official Dart formatting rules, fixes indentation, wraps long lines, and organizes trailing commas. Use `<leader>cf` for manual formatting or `:ConformInfo` to check the active formatter.

---

## 3. Working with the Widget Tree

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

## 4. Creating Flutter Files

Using oil.nvim to create a new widget file:
1. Press `-` to open the `lib/` directory
2. Navigate to the right subdirectory
3. Press `o` to add a new line
4. Type `my_new_widget.dart`
5. Press `<Esc>` then `:w`
6. Press `<CR>` on the new file to open it

---

## 5. CLI Companion Commands

These commands are run in a separate terminal (or Neovim's `:terminal`):

### Running

```bash
flutter run                    # Run on connected device / emulator
flutter run -d chrome          # Run with specific device
flutter run -d emulator-5554
flutter run --release          # Release mode
flutter run --profile          # Profile mode (performance)
```

### Testing

```bash
flutter test                          # Run all tests
flutter test test/widget_test.dart    # Run specific test file
flutter test --coverage               # Run with coverage
flutter test integration_test/        # Integration tests
```

### Building

```bash
flutter build apk              # Android APK
flutter build appbundle         # Android App Bundle
flutter build ios               # iOS
flutter build ipa
flutter build web               # Web
flutter build macos             # macOS
```

### Code Generation & Analysis

```bash
flutter analyze                                            # Analyze code
dart fix --apply                                           # Auto-fix lint issues
dart run build_runner build --delete-conflicting-outputs    # Generate code
dart run build_runner watch --delete-conflicting-outputs    # Watch mode
```

### Dependencies

```bash
flutter pub get                 # Get dependencies
flutter pub upgrade             # Upgrade dependencies
flutter pub add provider        # Add a package
flutter pub add --dev mockito   # Add dev dependency
flutter pub remove provider     # Remove a package
flutter pub outdated            # Check outdated packages
```

### Useful Dart Commands

```bash
dart format .                   # Format (same as on-save in Neovim)
dart format -l 120 .            # Format with custom line length
flutter create my_app           # Create a new project
flutter create --template=package my_package
flutter create --template=plugin my_plugin
```

---

## 6. Workflow Cheat Sheet

### Making a Change

1. Navigate to code: `<leader>sg` to grep, or `gd` to follow a definition
2. Edit the code — completion with `<C-y>`, snippets with `<Tab>`
3. Check for errors: `<leader>cl` for current line, `<leader>cd` for diagnostics list
4. Use code actions: `<leader>ca` to wrap widgets, extract methods, fix imports
5. Save: `:w` (auto-formats)

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
