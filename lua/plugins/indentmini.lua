return {
    "nvimdev/indentmini.nvim",
    config = function()
        require("indentmini").setup{
            minlevel = 2,
        }
    end,
}
