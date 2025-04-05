return {
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- "ibhagwan/fzf-lua",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        mappings = function()
            -- local map = vim.api.nvim_set_keymap
            -- map("n", "<C-'", ":Leet run", { silent=true })
            vim.keymap.set("n", "<C-'>", ":Leet run<CR>", { noremap=true, silent=false })
        end,
        opts = {
        },
        -- mappings = {
        --     vim.keymap.set("n", "<C-'>", ":Leet run<CR>", { noremap=true, silent=true })
        -- },
    }
}
