--- Plugin manager setup and plugin list

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({

	-- catppuccin colour scheme
	{
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-macchiato")
		end,
	},

	-- telescope (better search)
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ "<leader>fs", ":Telescope find_files<cr>", desc = "Fuzzy find files" },
			{ "<leader>fp", ":Telescope git_files<cr>", desc = "Fuzzy find git files" },
			{ "<leader>fz", ":Telescope live_grep<cr>", desc = "Live grep pattern" },
			{ "<leader>fo", ":Telescope oldfiles<cr>", desc = "Fuzzy find older files" },
		},
	},

	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Toggle file tree" },
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},

	-- visualise buffers as tabs
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup{}
		end,
	},

	-- lualine (status line)
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = ''},
					section_separators = { left = '', right = ''},
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					}
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch', 'diff', 'diagnostics'},
					lualine_c = {'filename'},
					lualine_x = {'encoding', 'fileformat', 'filetype'},
					lualine_y = {'progress'},
					lualine_z = {'location'}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {'filename'},
					lualine_x = {'location'},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {}
			}
		end,
	},

	-- Nvim comments
	{
		"terrortylor/nvim-comment",
		keys = {
			{ "<leader>/", ":CommentToggle<cr>", mode = {"n", "v"}, desc = "Toggle comment" },
		},
		config = function()
			require("nvim_comment").setup({ create_mappings = false })
		end
	},

	-- LSP configuration
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- Reserve a space in the gutter
			vim.opt.signcolumn = 'yes'

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			local lspconfig_defaults = require('lspconfig').util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lspconfig_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			-- Enable features when LSP is active
			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = {buffer = event.buf}

					vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
					vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
					vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
					vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
					vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
					vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
					vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
					vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				end,
			})

			-- Setup language servers
			require'lspconfig'.jedi_language_server.setup{}
		end,
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp', 
		event = {"InsertEnter", "CmdlineEnter" },
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			local luasnip = require("luasnip")
			local cmp = require('cmp')

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},

				completion = {
					autocomplete = false
				},

				mapping = cmp.mapping.preset.insert ({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<s-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<c-e>"] = cmp.mapping.abort(),

					["<CR>"] = cmp.mapping.confirm({ select=true }),
				}),
			})
		end,
	},
})
