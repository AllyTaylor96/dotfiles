return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Initialize Mason and its LSP bridge
    require('mason').setup()
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = { "pyright" }
    }
    vim.lsp.config('pyright', {
      capabilities = capabilities,
    })
    vim.lsp.enable('pyright')

    vim.diagnostic.config({
      virtual_lines = { current_line = true }, -- Enables inline error/warning text
    })
  end,
}