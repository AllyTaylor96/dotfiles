return {
  "akinsho/bufferline.nvim",
  version = "v4.*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Buffer Pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close Unpinned Buffers" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      numbers = "buffer_id",
      always_show_bufferline = false
    }
  }
}