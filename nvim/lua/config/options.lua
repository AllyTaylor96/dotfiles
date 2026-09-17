vim.g.loaded_python3_provider = 0

local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.mouse = "a"

opt.autowrite = true
opt.confirm = true
opt.inccommand = "nosplit"
opt.laststatus = 0
opt.list = true

opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.scrolloff = 4
opt.sidescrolloff = 8
opt.winminwidth = 5

opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.tabstop = 4

opt.showmode = false
opt.signcolumn = "yes"
opt.termguicolors = true
opt.hidden = true

opt.undofile = true
opt.undolevels = 10000

opt.secure = true
opt.exrc = true

-- Set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')