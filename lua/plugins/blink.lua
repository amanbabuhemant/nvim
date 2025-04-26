return {
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        -- dependencies = 'rafamadriz/friendly-snippets',

        version = '*',
        ---@module 'blink.cmp'
        ------@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-e: Hide menu
            -- C-k: Toggle signature help
            --
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'default' },

            appearance = {
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                -- nerd_font_variant = 'mono'
                kind_icons = {
                    Keyword = "K",
                    Function = "ƒ",
                    Variable = "v",
                    Snippet = "S",
                },
            },


            completion = {
                -- prevent selecting first complition item
                list = { selection = { preselect = false } },
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" },
    }
}
