--- A space for plugin-specific keymaps

--- Telescope (searching functionality)

-- Fuzzy find files (space file search)
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")

-- Fuzzy find git files
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")

-- Live grep pattern
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")

-- Fuzzy find older files
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")


--- Tree (File structure functionality)

-- Open file tree structure (space e)
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- To switch between windows, do Ctrl+W then left/right


--- Comment toggle

-- Flick on/off comments (space /)
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")
