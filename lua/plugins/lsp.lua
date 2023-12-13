local float = require("config.defaults").diagnostics_options.float
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                --TODO: enable inline hint with 0.10 release
                "ray-x/lsp_signature.nvim",
                opts = {
                    bind = true,
                    max_height = float.max_height,
                    max_width = float.max_width,
                    handler_opts = {
                        border = float.border,
                    },
                },
            },
            {
                "folke/neodev.nvim",
                ft = "lua",
                opts = { pathStrict = true, library = { plugins = { "nvim-dap-ui" }, types = true } },
            },
        },
        opts = {
            -- LSP Server Settings
            servers = {
                -- cssls = {},
                -- html = {},
                -- jsonls = {},
                -- tailwindcss = {},
                -- tsserver = {},
                -- volar = {},
                -- bashls = {
                --     filetypes = { "bash", "sh" },
                -- },
                phan = {},
                phpactor = {},
                -- TODO: fix psalm, lsp should be started with --language-server
                psalm = {},
                clangd = {
                    cmd = {
                        "clangd",
                        "--query-driver=/usr/bin/clang++",
                        "--clang-tidy",
                        "-j=5",
                        "--malloc-trim",
                        "--offset-encoding=utf-16",
                    },
                    filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
                },
                zls = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                                features = "all",
                            },
                        },
                    },
                },
                jedi_language_server = {},
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
                            -- disable lua_ls default formater since I use stylua
                            format = {
                                enable = false,
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            setup = {
                lua_ls = function(server, opts)
                    require("lspconfig")[server].setup(opts)
                end,
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                -- end,
            },
        },
        config = function(_, opts)
            local on_attach = function(client, bufnr)
                _ = client
                _ = bufnr
                -- if vim.filetype.match({ buf = bufnr }) == "lua" then
                -- end
                require("lspconfig.ui.windows").default_options = {
                    border = float.border,
                }
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
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            for server, _ in pairs(servers) do
                local server_config = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                    on_attach = on_attach,
                }, servers[server] or {})

                setup(server, server_config)
            end
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        opts = {
            ui = {
                border = float.border,
            },
            outline = {
                layout = "float",
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = function()
            local null_ls = require("null-ls")
            return {
                diagnostics_format = "#{m} (#{s})",
                sources = {
                    -- cpp
                    null_ls.builtins.diagnostics.cppcheck.with({
                        extra_args = {
                            "--inconclusive",
                        },
                    }),
                    -- python
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.pylint,
                    null_ls.builtins.diagnostics.mypy.with({
                        extra_args = {
                            "--strict",
                            "--disallow-any-unimported",
                            "--no-implicit-optional",
                            "--warn-unused-ignores",
                        },
                    }),
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.ruff,
                    null_ls.builtins.formatting.isort,
                    -- lua
                    null_ls.builtins.diagnostics.selene,
                    null_ls.builtins.formatting.stylua,
                    -- php
                    null_ls.builtins.diagnostics.php,
                    null_ls.builtins.diagnostics.phpstan,
                    -- psalm doesn't attach to buffer check null_ls
                    null_ls.builtins.diagnostics.psalm,
                    -- shell
                    null_ls.builtins.diagnostics.zsh.with({
                        filetypes = { "zsh" },
                    }),
                    null_ls.builtins.diagnostics.shellcheck.with({
                        filetypes = { "bash", "sh" },
                    }),
                    null_ls.builtins.code_actions.shellcheck.with({
                        filetypes = { "bash", "sh" },
                    }),
                    null_ls.builtins.hover.printenv.with({
                        filetypes = { "zsh", "bash", "sh", "dosbatch", "ps1" },
                    }),
                    -- opengl
                    null_ls.builtins.diagnostics.glslc.with({
                        extra_args = { "--target-env=opengl" }, -- use opengl instead of vulkan1.0
                    }),
                },
            }
        end,
    },
}
