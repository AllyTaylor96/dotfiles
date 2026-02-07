return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>fs", ":Telescope find_files<cr>", desc = "Fuzzy find files" },
		{ "<leader>fp", ":Telescope git_files<cr>", desc = "Fuzzy find git files" },
		{ "<leader>fz", ":Telescope live_grep<cr>", desc = "Live grep pattern" },
		{ "<leader>fo", ":Telescope oldfiles<cr>", desc = "Fuzzy find older files" },
	},
}
