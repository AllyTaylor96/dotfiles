return {
  -- theme
  -- { "catppuccin/nvim", lazy = true, name = "catppuccin", priority = 1000 },
  {
    "sainnhe/everforest",
    lazy = false,
    name = "everforest",
    priority = 1000,
    init = function()
      vim.g.everforest_enable_italic = true
    end,
    config = function()
      vim.cmd.colorscheme "everforest"
    end,
  },
}