return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        opts = {
            servers = {

                fortls = {},

                gopls = {
                    settings = {
                        gopls = {
                            staticcheck = true, -- Enable extra linting
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            }
                        }
                    }
                },

                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT", -- Neovim uses LuaJIT
                            },
                            diagnostics = {
                                globals = { "vim" }, -- Recognize `vim` as a global
                            },
                            workspace = {
                                checkThirdParty = false, -- Disable third-party plugin checks
                                library = vim.api.nvim_get_runtime_file("", true), -- Recognize Neovim runtime
                            },
                            telemetry = {
                                enable = false, -- Disable telemetry
                            },
                        }
                    }
                },

                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic", -- Basic type checking
                            }
                        }
                    }
                },

            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            local blink_cmp = require('blink.cmp')

            -- Ensure blink.cmp is properly initialized
            blink_cmp.setup()

            -- Loop through servers and configure them
            for server, config in pairs(opts.servers) do
                config.capabilities = blink_cmp.get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    }
}
