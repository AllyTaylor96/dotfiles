return {
	"github/copilot.vim",
	event = "VimEnter",  -- Load when Vim loads to ensure it's available in all buffers
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	end,
}
