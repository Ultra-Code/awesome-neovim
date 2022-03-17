local disable_conflicting_formatters = function(client, buffer)
    local buffer_filetype = vim.fn.getbufvar(buffer, "&filetype")

    local disabled_files = buffer_filetype == "cpp"
        or buffer_filetype == "javascript"
        or buffer_filetype == "typescript"

    if client.name == "null-ls" and disabled_files then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end
end

local on_attach = function(client, buffer)
    vim.diagnostic.config({
        virtual_text = false,
        float = { scope = "line", severity_sort = true, source = "if_many" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
    local signature_cfg = require("plugrc.lspconfig.signature")
    require("lsp_signature").on_attach(signature_cfg)

    local function set_keymap(...)
        vim.api.nvim_buf_set_keymap(buffer, ...)
    end

    local function set_option(...)
        vim.api.nvim_buf_set_option(buffer, ...)
    end

    set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }

    disable_conflicting_formatters(client, buffer)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_range_formatting then
        set_keymap(
            "v",
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
            opts
        )
    end
end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,

        -- rootdir = vim.loop.cwd
    }
end

-- lsp-install
local function setup_servers()
    local lsp_servers = {
        "sumneko_lua",
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

    local null_ls = require("null-ls")

    null_ls.setup({
        diagnostics_format = "#{m} (#{s})",
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.cppcheck.with({
                extra_args = {
                    "--inconclusive",
                },
            }),
        },
    })

    for _, server in pairs(lsp_servers) do
        local config = make_config()
        local settings = require("plugrc.lspconfig.settings")

        -- language specific config
        if server == "clangd" then
            local clangd_settings = settings.clangd_setting
            config.cmd = clangd_settings.cmd
            config.filetypes = clangd_settings.filetypes
        end

        if server == "sumneko_lua" then
            local lua_settings = settings.lua_settings
            config.cmd = lua_settings.cmd
            config.settings = lua_settings.settings
        end
        require("lspconfig")[server].setup(config)
    end
end

setup_servers()
