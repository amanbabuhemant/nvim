return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua" },  -- Install Lua parser
        highlight = { enable = true },  -- Enable syntax highlighting
      })
    end
  }
}
