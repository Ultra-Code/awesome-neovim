local autocmd = vim.api.nvim_create_autocmd -- create autocmd

local on_attach = function(client, bufnr)
    _ = client;
    _ = bufnr;
    -- options from nvim_open_win()| vim.diagnostic.open_float()
    -- | vim.lsp.util.open_floating_preview()| vim.diagnostic.config()
    local opts = {
        virtual_text = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        focusable = false,
        float = {
            source = "if_many",
            -- "single": A single line box.
            -- "double": A double line box.
            -- "rounded": Like "single", but with rounded corners "╭"
            -- "solid": Adds padding by a single whitespace cell.
            -- "shadow": A drop shadow effect by blending with the
            -- "none": No border (default).
            border = "rounded",
        },
        severity_sort = true,
    }
    vim.diagnostic.config(opts)

    -- automatically show diagnostics on current line
    autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
            vim.diagnostic.open_float(nil, {
                focus = false,
            })
        end
    })

    require('lspconfig.ui.windows').default_options = {
        border = opts.float.border,
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = opts.float.border,
        }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = opts.float.border,
        }
    )
end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
    }
end

-- lsp-install
local function setup_servers()
    local lsp_servers = {
        "lua_ls",
        "clangd",
        "cssls",
        "html",
        "jsonls",
        "tailwindcss",
        "tsserver",
        "volar",
        "zls",
        "bashls",
    }

     --local signature_cfg = require("plugrc.lspconfig.signature")
     --require("lsp_signature").setup(signature_cfg)

    for _, server in pairs(lsp_servers) do
        local config = make_config()
        local settings = require("plugrc.lspconfig.settings")

        -- language specific config
        if server == "clangd" then
            local clangd_settings = settings.clangd_setting
            config.cmd = clangd_settings.cmd
            config.filetypes = clangd_settings.filetypes
        end

        if server == "lua_ls" then
            local lua_settings = settings.lua_settings
            config.cmd = lua_settings.cmd
            config.settings = lua_settings.settings
        end
        require("lspconfig")[server].setup(config)
    end

    local null_ls = require("null-ls")

    null_ls.setup({
        diagnostics_format = "#{m} (#{s})",
        sources = {
            null_ls.builtins.diagnostics.cppcheck.with({
                extra_args = {
                    "--inconclusive",
                },
            }),
            null_ls.builtins.diagnostics.zsh,
        },
    })
end

setup_servers()
