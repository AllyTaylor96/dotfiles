return {
	'neovim/nvim-lspconfig',
	config = function()
		-- Reserve a space in the gutter
		vim.opt.signcolumn = 'yes'

		-- Add cmp_nvim_lsp capabilities to LSP clients
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		vim.lsp.config('*', {
			capabilities = capabilities,
		})

		local function format_fallback(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()

			for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
				if client.supports_method and (client:supports_method('textDocument/formatting') or client:supports_method('textDocument/rangeFormatting')) then
					vim.lsp.buf.format({ async = true, bufnr = bufnr })
					return
				end
			end

			if vim.bo[bufnr].filetype ~= 'python' then
				vim.notify('No LSP formatter attached for this buffer', vim.log.levels.WARN)
				return
			end

			local filename = vim.api.nvim_buf_get_name(bufnr)
			local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n') .. '\n'

			local cmd
			if vim.fn.executable('ruff') == 1 then
				cmd = { 'ruff', 'format', '--stdin-filename', filename, '-' }
			elseif vim.fn.executable('black') == 1 then
				cmd = { 'black', '--quiet', '--stdin-filename', filename, '-' }
			else
				vim.notify("No Python formatter found. Install 'ruff' (recommended) or 'black'.", vim.log.levels.WARN)
				return
			end

			local out = vim.fn.system(cmd, input)
			if vim.v.shell_error ~= 0 then
				vim.notify(out, vim.log.levels.ERROR)
				return
			end

			local lines = vim.split(out, '\n', { plain = true })
			if lines[#lines] == '' then
				table.remove(lines, #lines)
			end
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
		end

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
				vim.keymap.set({ 'n', 'x' }, '<F3>', function()
					format_fallback(event.buf)
				end, opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end,
		})

		-- Enable LSP servers (nvim-lspconfig provides the configs automatically)
		vim.lsp.enable('jedi_language_server')
		vim.lsp.enable('bashls')
	end,
}
