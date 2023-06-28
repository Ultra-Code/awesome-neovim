-- local diagnostics_options = require("config.defaults").diagnostics_options
return {
    { "folke/neodev.nvim", event = "VeryLazy", opts = { pathStrict = true } },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "jose-elias-alvarez/null-ls.nvim",
                opts = function()
                    local null_ls = require("null-ls")
                    return {
                        diagnostics_format = "#{m} (#{s})",
                        sources = {
                            null_ls.builtins.diagnostics.cppcheck.with({
                                extra_args = {
                                    "--inconclusive",
                                },
                            }),
                            null_ls.builtins.diagnostics.zsh.with({
                                filetypes = { "zsh" }
                            }),
                            null_ls.builtins.diagnostics.shellcheck.with({
                                filetypes = { "bash", "sh" },
                            }),
                            null_ls.builtins.diagnostics.glslc.with({
                                extra_args = { "--target-env=opengl" }, -- use opengl instead of vulkan1.0
                            }),
                            null_ls.builtins.code_actions.shellcheck.with({
                                filetypes = { "bash", "sh" },
                            }),
                            null_ls.builtins.code_actions.gitsigns,
                            null_ls.builtins.hover.printenv.with({
                                filetypes = { "zsh", "bash", "sh", "dosbatch", "ps1" },
                            })
                        },
                    }
                end,
                config = function(_, opts)
                    require("null-ls").setup(opts)
                end,
            },
        },
        ---@class PluginLspOpts
        opts = {
            -- LSP Server Settings
            servers = {
                -- cssls = {},
                -- html = {},
                -- jsonls = {},
                -- tailwindcss = {},
                -- tsserver = {},
                -- volar = {},
                bashls = {
                    filetypes = { "zsh", "bash", "sh" },
                },
                clangd = {
                    cmd = {
                        "clangd",
                        "--query-driver=/usr/bin/clang++",
                        "--clang-tidy",
                        "-j=5",
                        "--malloc-trim",
                        "--offset-encoding=utf-16"
                    },
                    filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
                },
                zls = {},
                lua_ls = {
                    cmd = {
                        "lua-language-server",
                        "-E",
                        "/usr/share/lua-language-server/main.lua",
                    },
                    settings = {
                        Lua = {
                            runtime = {
                                -- LuaJIT in the case of Neovim
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { "vim" },
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                                -- This feature causes the lsp to use the "environment emulation" feature to suggest
                                -- applying a library/framework when a certain keyword or filename has been found
                                checkThirdParty = false,
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            setup = {
                lua_ls = function(server, opts)
                    require("neodev").setup()
                    require("lspconfig")[server].setup(opts)
                end
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                -- end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local on_attach = function(client, bufnr)
                _ = client;
                _ = bufnr;
                -- if vim.filetype.match({ buf = bufnr }) == "lua" then
                -- end
                -- require('lspconfig.ui.windows').default_options = {
                --     border = diagnostics_options.float.border,
                -- }
            end


            local function setup(server, server_config)
                if opts.setup[server] then
                    if opts.setup[server](server, server_config) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_config)
            end

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            for server, _ in pairs(servers) do
                local server_config = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = on_attach,
                }, servers[server] or {})

                setup(server, server_config)
            end
        end,
    }
}
