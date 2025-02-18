--- A place for plugin-specific options

-- set colour theme
vim.cmd("colorscheme catppuccin-macchiato")

-- Set bufferline options
vim.opt.termguicolors = true -- bufferline
require("bufferline").setup{} --bufferline
