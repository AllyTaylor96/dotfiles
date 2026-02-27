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

		local function ruff_check_quickfix(bufnr)
			bufnr = bufnr or vim.api.nvim_get_current_buf()

			if vim.bo[bufnr].filetype ~= 'python' then
				vim.notify('Ruff check is only configured for Python buffers', vim.log.levels.WARN)
				return
			end

			if vim.fn.executable('ruff') ~= 1 then
				vim.notify("Ruff not found. Install with `pip install -U ruff`.", vim.log.levels.WARN)
				return
			end

			local filename = vim.api.nvim_buf_get_name(bufnr)
			if filename == '' then
				filename = 'stdin.py'
			end

			local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n') .. '\n'
			local cmd = { 'ruff', 'check', '--output-format=concise', '--stdin-filename', filename, '-' }

			local out = vim.fn.system(cmd, input)
			local exit = vim.v.shell_error

			if exit == 0 then
				vim.fn.setqflist({}, 'r', { title = 'Ruff', items = {} })
				vim.cmd('cclose')
				vim.notify('Ruff: no issues found', vim.log.levels.INFO)
				return
			end
			if exit == 2 then
				vim.notify(out, vim.log.levels.ERROR)
				return
			end

			local lines = vim.split(out, '\n', { plain = true })
			if lines[#lines] == '' then
				table.remove(lines, #lines)
			end

			local items = {}
			for _, line in ipairs(lines) do
				local f, l, c, msg = line:match('^(.-):(%d+):(%d+):%s*(.+)$')
				if f and l and c and msg then
					table.insert(items, { filename = f, lnum = tonumber(l), col = tonumber(c), text = msg })
				end
			end

			vim.fn.setqflist({}, 'r', { title = 'Ruff', items = items })
			if #items > 0 then
				vim.cmd('copen')
			else
				vim.notify('Ruff: no parseable output', vim.log.levels.WARN)
			end
		end

		-- Enable features when LSP is active
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }

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
				vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

				if vim.bo[event.buf].filetype == 'python' then
					vim.keymap.set('n', '<F4>', function()
						ruff_check_quickfix(event.buf)
					end, opts)
				else
					vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				end
			end,
		})

		-- Enable LSP servers (nvim-lspconfig provides the configs automatically)
		vim.lsp.enable('jedi_language_server')
		vim.lsp.enable('bashls')
	end,
}
