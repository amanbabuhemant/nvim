return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = false,
            component_separators = { left = "┊", right = "┊" },
            section_separators = { left = "🬻◣🬞", right = "🬏◢🬺"},
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        while #str < 7 do
                            str = str .. " "
                        end return str end
                }
            },
            lualine_b = {},
            lualine_c = { "filename", "diff"},
            lualine_x = { "filetype", "diagnostics", 'encoding'},
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    },
}
