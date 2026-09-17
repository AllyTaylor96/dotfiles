# NeoVim Configuration User Guide

This guide explains the functionality and keybindings configured in this NeoVim setup.

---

## Requirements

To use this configuration at full capacity, ensure the following are installed
(or just run `./bootstrap.sh`):

### Core Requirements
- **Neovim 0.10+** - For modern LSP support
- **Git** - Required by lazy.nvim plugin manager
- **make** and a **C compiler** (gcc/clang) - Required to build
  `telescope-fzf-native.nvim` and Treesitter parsers
- **Node.js/npm** - Required by `mason.nvim` to install and manage the
  `pyright` language server

### Language Servers (for LSP features)
- **Python**: `pyright` - installed automatically by `mason.nvim` on first launch

### Linting & Formatting
- **Python**: `pylint` (diagnostics) and `black` (formatting), wired up via
  `none-ls.nvim`
  - `pip3 install --user -U pylint black`

### Required for Search
- **ripgrep** - Required for Telescope live grep
  - Debian/Ubuntu: `sudo apt install ripgrep`
  - macOS: `brew install ripgrep`

### Optional
- **Nerd Font** - For icons in the bufferline and status line
  - Download from [nerdfonts.com](https://www.nerdfonts.com/)

---

## Leader Key

The leader key is set to **`<Space>`** (spacebar). Most custom commands start with the leader key.

---

## Core Keybindings (Non-Plugin)

### Terminal
- `<C-s>` - Toggle a floating/split terminal (via toggleterm)
- `<Esc>` (in terminal mode) - Exit terminal mode back to normal mode
- `<C-w>` (in terminal mode) - Exit terminal mode and move to another window
- `<C-g>` - Minimize the current terminal split down to 3 lines

### Movement
- `<Up>` / `<Down>` - Move by display (wrapped) line instead of file line,
  unless a count is given (e.g. `5j` still moves 5 real lines)

### LSP
- `K` - Show hover documentation for symbol under cursor
- `<leader>rn` - Rename symbol under cursor
- `<leader>gd` - Go to definition
- `<leader>ca` - Show available code actions
- `<leader>ff` - Format current buffer (LSP formatting; Python formatting is
  handled by `black` via none-ls)

### Misc
- `<Space>` (normal/visual mode) - No-op, so accidental presses do nothing
  before a leader sequence is typed

---

## Plugin Features & Keybindings

### File Navigation (Telescope)
Telescope provides fuzzy finding for files, text, and symbols, accelerated by
`telescope-fzf-native.nvim`.

- `<leader>sf` - Find git-tracked files in the project
- `<leader><space>` - Find/switch between open buffers
- `<leader>sg` - Live grep across the project (requires `ripgrep`)
- `<leader>ss` - Search LSP document symbols (current buffer)
- `<leader>sw` - Search LSP workspace symbols

### Buffers (Bufferline)
Tab-like display of open buffers at the top of the window.

- `<leader>bp` - Toggle pin on the current buffer
- `<leader>bP` - Close all unpinned buffers

### Terminal (toggleterm)
- `<C-s>` - Toggle a terminal window (opens at a height of 10 rows)

### LSP (Language Server Protocol)
LSP servers are installed/managed via `mason.nvim` + `mason-lspconfig.nvim`.
Currently configured: `pyright` (Python).

- See the [Core Keybindings](#core-keybindings-non-plugin) section above for
  LSP mappings (`K`, `<leader>rn`, `<leader>gd`, `<leader>ca`, `<leader>ff`)
- Diagnostics are shown inline as virtual text on the current line

### Autocompletion (nvim-cmp + LuaSnip)
Completion is manually triggered rather than firing automatically as you type.

- `<Tab>` - Open completion menu / select next item / expand or jump in a snippet
- `<Shift-Tab>` - Select previous completion item / jump backward in a snippet
- `<C-e>` - Abort/close the completion menu
- `<CR>` - Confirm the selected completion item

Snippets are loaded from the `snippets/` directory (Lua snippet format) via LuaSnip.

### Linting & Formatting (none-ls)
- **Python diagnostics**: `pylint`
- **Python formatting**: `black` (triggered via `<leader>ff`, which calls
  `vim.lsp.buf.format`)

### Syntax Highlighting (Treesitter)
Highlighting and incremental selection for: `c`, `lua`, `vim`, `vimdoc`,
`query`, `python`, `javascript`.

- `<C-n>` - Start/expand incremental selection
- `<C-s>` - Shrink to the next-larger scope (inside an active selection)
- `<C-m>` - Shrink selection

### Editing Helpers (mini.nvim)
- **mini.pairs** - Automatically closes brackets/quotes as you type
- **mini.surround** - Add/change/delete surrounding pairs (see `:h
  MiniSurround` for its default mappings, e.g. `sa` to add, `sd` to delete,
  `sr` to replace)

### Indentation Guides (indent-blankline)
Displays vertical guide lines for indentation levels.

---

## Editor Settings

### Display
- **Line numbers**: Enabled (hybrid: absolute for current line, relative for others)
- **Color scheme**: Everforest
- **Syntax highlighting**: Treesitter-based, with true color support
- **Status line**: Lualine shows mode, branch, diagnostics, file info
- **Buffer line**: Bufferline shows open buffers as tabs at the top

### Indentation & Formatting
- **Default**: 4 spaces (tabs converted to spaces)
- **Show whitespace**: Enabled (`list` option on)

### Search Behavior
- **Case-insensitive**: Search ignores case...
- **Smart case**: ...unless you use capital letters
- **No persistent highlight**: Previous search results are not highlighted

### Scrolling
- **Scroll offset**: Keeps 4 lines visible above/below cursor, 8 columns to the side

### Misc
- **Clipboard**: Uses the system clipboard by default (`unnamedplus`)
- **Undo**: Persistent undo history saved to disk (`undofile`)
- **Splits**: New splits open below/right by default

---

## Language Support

### Python
- **LSP**: `pyright` (autocomplete, go-to-definition, hover, etc.)
- **Linting**: `pylint` via none-ls
- **Formatting**: `black` via none-ls (`<leader>ff`)

### Other Filetypes
- **Treesitter highlighting**: `c`, `lua`, `vim`, `vimdoc`, `query`, `javascript`
- No dedicated LSP servers are currently configured for these; add entries in
  `lua/plugins/lsp.lua` (`ensure_installed` + `vim.lsp.enable(...)`) as needed

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

1. **Quick grep**: Use `<leader>sg` to search for text across the entire project
2. **Buffer switching**: Use `<leader><space>` to fuzzy-find and jump between open buffers
3. **LSP hover**: Hover over any Python function/class with `K` to see documentation
4. **Pin important buffers**: Use `<leader>bp` to pin a buffer so it survives bulk closes
5. **Terminal workflow**: Use `<C-s>` to pop open a terminal without leaving Neovim, then `<C-g>` to shrink it out of the way

---

## Plugin List

- **everforest**: Color scheme
- **nvim-web-devicons**: Filetype icons used by bufferline/lualine
- **LuaSnip**: Snippet engine (loads snippets from `snippets/`)
- **nvim-lspconfig** + **mason.nvim** + **mason-lspconfig.nvim**: Language server management (pyright)
- **nvim-cmp** + **cmp-nvim-lsp** + **cmp_luasnip**: Autocompletion engine
- **nvim-treesitter**: Syntax highlighting and incremental selection
- **telescope.nvim** + **telescope-fzf-native.nvim**: Fuzzy finder and live grep
- **none-ls.nvim**: Linting (pylint) and formatting (black)
- **toggleterm.nvim**: Integrated terminal
- **lualine.nvim**: Status line
- **bufferline.nvim**: Buffer tabs
- **mini.pairs** / **mini.surround**: Auto-pairing and surround text objects
- **indent-blankline.nvim**: Indentation guide lines

---

## Troubleshooting

**LSP not working?**
- Check `:Mason` to confirm `pyright` is installed
- Check LSP status with `:LspInfo` or `:checkhealth lsp` when a file is open
- Verify Neovim version is 0.10+ with `:version`

**Telescope not finding files?**
- Make sure you're in a git repository - `<leader>sf` uses `git_files`, which
  requires the project to be tracked by git
- Use `<leader>sg` to grep for text instead

**Telescope live grep errors?**
- `ripgrep` is required for live grep - install with `brew install ripgrep`
  (macOS) or `sudo apt install ripgrep` (Linux)

**telescope-fzf-native fails to build?**
- Ensure `make` and a C compiler are installed, then run `:Lazy build
  telescope-fzf-native.nvim`

**Formatting/linting not happening?**
- Ensure `pylint` and `black` are on your `PATH` (`pip3 install --user -U
  pylint black`)
- Check `:NullLsInfo` to confirm sources are attached to the current buffer

**Autocomplete not appearing?**
- Completion is manual - press `<Tab>` to trigger it
- Ensure an LSP server is running for the file type (check with `:LspInfo`)
