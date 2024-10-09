local float = require("config.defaults").diagnostics_options.float
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "ray-x/lsp_signature.nvim",
                opts = {
                    bind = true,
                    max_height = float.max_height,
                    max_width = float.max_width,
                    hint_inline = function()
                        return vim.version.gt(vim.version(), { 0, 9, 0 })
                    end,
                    handler_opts = {
                        border = float.border,
                    },
                },
            },
            {
                "folke/neodev.nvim",
                ft = "lua",
                opts = {
                    pathStrict = true,
                    library = { plugins = { "nvim-dap-ui" }, types = true },
                },
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
                bashls = {
                    filetypes = { "bash", "sh" },
                },
                mojo = {},
                -- use pylsp-mypy for mypy
                -- use python-lsp-ruff for ruff
                -- use pylsp-inlay-hints for inlay hints
                pylsp = {},
                phan = {},
                phpactor = {},
                psalm = {},
                clangd = {
                    cmd = {
                        "clangd",
                        "--clang-tidy",
                        "-j=5",
                        "--malloc-trim",
                    },
                    filetypes = { "c" }, -- "cpp"
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
                lua_ls = {
                    cmd = {
                        "lua-language-server",
                        "-E",
                        "/usr/share/lua-language-server/main.lua",
                    },
                    on_init = function(client)
                        if client.workspace_folders then
                            local path = client.workspace_folders[1].name
                            if
                                vim.uv.fs_stat(path .. "/.luarc.json")
                                or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                            then
                                return
                            end
                        end
                    end,
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
                                library = vim.env.VIMRUNTIME,
                                -- This feature causes the lsp to use the "environment emulation" feature to suggest
                                -- applying a library/framework when a certain keyword or filename has been found
                                checkThirdParty = false,
                            },
                            -- disable lua_ls default formater since I use stylua
                            format = { enable = false },
                            hint = { enable = true, setType = true },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            setup = {
                lua_ls = function(server, opts)
                    require("lspconfig")[server].setup(opts)
                end,
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

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
                    -- lua
                    null_ls.builtins.diagnostics.selene,
                    null_ls.builtins.formatting.stylua,
                    -- php
                    null_ls.builtins.diagnostics.phpstan,
                    null_ls.builtins.formatting.phpcsfixer,
                    -- shell
                    null_ls.builtins.diagnostics.zsh.with({
                        filetypes = { "zsh" },
                    }),
                    null_ls.builtins.hover.printenv.with({
                        filetypes = { "zsh", "bash", "sh", "dosbatch", "ps1" },
                    }),
                    -- Docker
                    null_ls.builtins.diagnostics.hadolint,
                    -- opengl
                    null_ls.builtins.diagnostics.glslc.with({
                        -- use opengl instead of vulkan1.0
                        extra_args = { "--target-env=opengl" },
                    }),
                },
            }
        end,
    },
}
