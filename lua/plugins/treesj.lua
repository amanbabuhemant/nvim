return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({
            use_default_keymaps = true,
        })
        -- Split <-> Join
        vim.keymap.set('n', '<leader>m', require('treesj').toggle)
        -- Split <-> Join with recursive
        vim.keymap.set('n', '<leader>M', function()
            require('treesj').toggle({ split = { recursive = true } })
        end)
    end,
}
