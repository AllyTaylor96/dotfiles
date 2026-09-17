-- NOTE: nvim-treesitter's `main` branch is a full rewrite that requires
-- Neovim 0.12+ (nightly) and drops the old incremental_selection/highlight
-- module system. We're on Neovim 0.11, so we pin the `master` branch, which
-- is frozen specifically to keep working on Neovim <=0.11.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },
      auto_install = false,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-m>",
        }
      }
    })
  end
}
