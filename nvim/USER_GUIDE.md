# NeoVim Configuration User Guide

This guide explains the functionality and keybindings configured in this NeoVim setup.

## Leader Key

The leader key is set to **`<Space>`** (spacebar). Most custom commands start with the leader key.

---

## Core Keybindings (Non-Plugin)

### Buffer/Tab Management
- `<Space>n` - Next buffer/tab
- `<Space>p` - Previous buffer/tab
- `<Space>x` - Close current buffer/tab

### Window Navigation
- `F8` - Switch to left window
- `F9` - Switch to right window
- `Ctrl+W` then arrow keys - Navigate between windows (Vim default)

### Clipboard Operations
- `<Space>y` - Yank (copy) to system clipboard (normal and visual mode)

### Code Folding
- `<Space><Space>` - Toggle fold at current line (folds based on indentation)
- `zo` - Open fold under cursor (Vim default)
- `zc` - Close fold under cursor (Vim default)
- `za` - Toggle fold under cursor (Vim default)

---

## Plugin Features & Keybindings

### File Navigation (Telescope)
Telescope provides fuzzy finding for files and text.

- `<Space>fs` - **F**ile **S**earch: Fuzzy find files in project
- `<Space>fp` - **F**ile **P**roject: Fuzzy find git files only
- `<Space>fz` - **F**ile **Z** (grep): Live grep/search text across all files
- `<Space>fo` - **F**ile **O**ld: Fuzzy find recently opened files

### File Tree (NvimTree)
File explorer sidebar for browsing project structure.

- `<Space>e` - Toggle file tree sidebar (opens at current file location)

**Inside NvimTree:**
- `Enter` - Open file/directory
- `Ctrl+W` then `h/l` - Switch between tree and editor window

### Comments (nvim-comment)
- `<Space>/` - Toggle comment on current line or selected lines (normal and visual mode)

### LSP (Language Server Protocol)
These keybindings are available when a language server is active for the file.

**Navigation:**
- `K` - Show hover documentation for symbol under cursor
- `gd` - **G**o to **d**efinition
- `gD` - **G**o to **D**eclaration
- `gi` - **G**o to **i**mplementation
- `go` - **G**o to type definition
- `gr` - **G**o to **R**eferences (find all uses)
- `gs` - Show **S**ignature help

**Code Actions:**
- `F2` - Rename symbol under cursor
- `F3` - Format document (normal) or selection (visual)
- `F4` - Show available code actions

### Autocompletion (nvim-cmp)
Autocomplete appears automatically when you start typing or press `Tab`.

- `Tab` - Trigger/navigate to next completion item or expand snippet
- `Shift+Tab` - Navigate to previous completion item
- `Ctrl+E` - Abort/close completion menu
- `Enter` - Confirm selected completion

---

## Editor Settings

### Display
- **Line numbers**: Enabled (hybrid: absolute for current line, relative for others)
- **Color scheme**: Catppuccin Macchiato
- **Syntax highlighting**: Enabled with true color support
- **Status line**: Lualine shows mode, branch, diagnostics, file info
- **Buffer line**: Tabs at top show open buffers

### Indentation & Formatting
- **Default**: 4 spaces (tabs converted to spaces)
- **JavaScript/HTML/CSS/Lua**: 2 spaces (auto-detected)
- **Auto-indent**: Enabled
- **Show whitespace**: Tabs and trailing spaces visible

### Text Wrapping
- **Soft wrap**: Enabled (text wraps at window edge, no hard line breaks)
- **No text width limit**: Text doesn't auto-wrap while typing

### Search Behavior
- **Case-insensitive**: Search ignores case...
- **Smart case**: ...unless you use capital letters
- **Incremental search**: Highlights matches as you type
- **No persistent highlight**: Previous search results not highlighted

### Scrolling
- **Scroll offset**: Keeps 8 lines visible above/below cursor when scrolling

### Code Folding
- **Method**: Based on indentation
- **Toggle**: `<Space><Space>`

---

## Language Support

### Python
- **LSP**: Jedi Language Server (autocomplete, go-to-definition, etc.)
- **Indentation**: 4 spaces
- **Formatting**: Available via LSP (F3)

### JavaScript/HTML/CSS/Lua
- **Indentation**: Auto-switches to 2 spaces
- **File detection**: Automatic

### JSON
- **Special**: `.ujson` files treated as JSON

---

## Useful Vim Defaults to Remember

- `i` - Enter insert mode at cursor
- `a` - Enter insert mode after cursor
- `o` - Insert new line below and enter insert mode
- `O` - Insert new line above and enter insert mode
- `v` - Enter visual mode (character selection)
- `V` - Enter visual line mode (line selection)
- `:w` - Save file
- `:q` - Quit
- `:wq` or `ZZ` - Save and quit
- `u` - Undo
- `Ctrl+R` - Redo
- `dd` - Delete (cut) line
- `yy` - Yank (copy) line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `*` - Search for word under cursor

---

## Tips & Tricks

1. **File tree + split windows**: Open file tree with `<Space>e`, then open files in splits for side-by-side editing
2. **Quick grep**: Use `<Space>fz` to search for text across entire codebase
3. **Recent files**: Use `<Space>fo` to quickly reopen recently edited files
4. **LSP features**: Hover over any Python function/class with `K` to see documentation
5. **Copy to clipboard**: Select text in visual mode, then `<Space>y` to copy to system clipboard
6. **Comment blocks**: Select multiple lines with `V`, then `<Space>/` to toggle comments

---

## Plugin List

- **Catppuccin**: Color scheme (macchiato variant)
- **Telescope**: Fuzzy finder and live grep
- **NvimTree**: File explorer
- **Bufferline**: Tab-like buffer display at top
- **Lualine**: Informative status line at bottom
- **nvim-comment**: Easy commenting
- **nvim-lspconfig**: Language server integration
- **nvim-cmp**: Autocompletion engine
- **LuaSnip**: Snippet engine

---

## Troubleshooting

**LSP not working?**
- Ensure Jedi language server is installed: `pip install jedi-language-server`

**Telescope not finding files?**
- Make sure you're in a project directory
- Use `<Space>fs` for all files or `<Space>fp` for git-tracked files only

**Telescope errors when live_grepping using Telescope?**
- `ripgrep` is required for live grepping to work - can install using either `brew install ripgrep` (macOS) or `sudo apt-get install ripgrep` (Linux)

**File tree not showing?**
- Press `<Space>e` to toggle it
- Use `Ctrl+W` then `h` to focus the tree

**Autocomplete not appearing?**
- Press `Tab` to trigger manually
- Autocomplete is disabled by default and triggers on Tab or when typing
