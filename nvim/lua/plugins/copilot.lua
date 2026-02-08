return {
	"github/copilot.vim",
	event = "VimEnter",  -- Load when Vim loads to ensure it's available in all buffers
	config = function()
    -- Disable the default Tab mapping for Copilot
		vim.g.copilot_no_tab_map = true
    -- Map Ctrl-Space to accept Copilot suggestions
		vim.api.nvim_set_keymap("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    -- Disable by default
    vim.g.copilot_filetypes = {["*"] = false,}
    -- Explicitly request for copilot suggestions on Ctrl-Enter
    vim.keymap.set('i', '<C-CR>', '<Plug>(copilot-suggest)')
	end,
}
