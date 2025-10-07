return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "markdown", "markdown_inline" },  -- Install Lua parser
                highlight = {
                    enable = true,  -- Enable syntax highlighting
                    additional_vim_regex_highlighting = { "htmldjango" },
                },
                auto_install = true, -- Install missing parser on fly
            })
        end
    }
}
