return {
    "junegunn/vim-easy-align",
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        map("v", "ga", ":EasyAlign<CR>", opts)
        map("n", "ga", ":EasyAlign<CR>", opts)
    end
}
