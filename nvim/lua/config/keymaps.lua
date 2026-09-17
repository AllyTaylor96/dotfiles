-- Terminal keymaps
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")
vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>")

-- Minimize terminal split
vim.keymap.set('n', '<C-g>', "3<C-w>_")

-- Up / down with line wrap
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- LSP keybindings
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = 'Rename Symbol'})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {desc = 'Goto Definition'})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = 'Code Action'})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover Documentation'})
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, {desc = 'Format Code'})