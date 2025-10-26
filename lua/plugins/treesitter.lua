return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "markdown", "markdown_inline" },
                highlight = {
                    enable = true,
                    disable = { "htmldjango" },
                },
                indent = {
                    enable = true,
                    disable = { "python" },
                },
                auto_install = true, -- Install missing parser on fly
            })
        end
    }
}
