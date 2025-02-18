-- A space for non-plugin-specific keymap bindings

--- Set Neovim wide leader key to be 'spacebar' - all commnds will be 'space' then '<KEY>'
vim.g.mapleader = " "

--- Switching between buffers/tabs

-- Next buffer/tab
vim.keymap.set("n", "<leader>n", ":bn<cr>")

-- Previous buffer/tab
vim.keymap.set("n", "<leader>p", ":bp<cr>")

-- Close buffer/tab
vim.keymap.set("n", "<leader>x", ":bd<cr>")


--- Yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

--- Set double space to toggle fold on indent
vim.keymap.set("n", "<leader><leader>", "za")


