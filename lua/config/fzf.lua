return {
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        init = function()
            -- Set FZF command prefix
            vim.g.fzf_command_prefix = "Fzf"
        end,
        config = function()
            -- Key mappings for FZF
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            map("n", "<Leader>p", ":FzfFiles<CR>", opts)
            map("n", "<Leader>f", ":FzfRg<CR>", opts)
            map("n", "<Leader>b", ":FzfBuffers<CR>", opts)
            map("n", "<Leader>h", ":FzfHistory<CR>", opts)
        end,
    }
}
