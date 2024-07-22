local autocmd = vim.api.nvim_create_autocmd -- create autocmd
local utils = require("config.utils")
local map = utils.map
local augroup = utils.augroup

-- map the following keys after the language server attaches to a buffer
-- See `:help vim.lsp.*` for doc mentation on any of the below functions
-- :lua =vim.lsp.get_active_clients()[1].server_capabilities to get capabilities of lsp attached to buffer
utils.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    if
        vim.version.gt(vim.version(), { 0, 9, 0 })
        and client.server_capabilities.inlayHintProvider
    then
        vim.lsp.inlay_hint.enable(true)
    end
    if client.server_capabilities.hoverProvider then
        map("n", "K", function()
            vim.lsp.buf.hover()
        end, opts, "get hover info")
    end
    if client.server_capabilities.semanticTokensProvider then
        map("n", "<localleader>us", function()
            utils.toggle("enable_semantic_tokens", { global = true }, nil)
            if vim.g["enable_semantic_tokens"] then
                vim.lsp.semantic_tokens.start(bufnr, client.id)
            else
                vim.lsp.semantic_tokens.stop(bufnr, client.id)
            end
        end, opts, "toggle semantic token highlighting")
    end
    if client.server_capabilities.signatureHelpProvider then
        map(
            "n",
            "<localleader>k",
            vim.lsp.buf.signature_help,
            opts,
            "get fn signature help"
        )
    end
    if client.server_capabilities.declarationProvider then
        map(
            "n",
            "<localleader>gD",
            vim.lsp.buf.declaration,
            opts,
            "goto declaration"
        )
    end
    if client.server_capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        map("n", "<localleader>gd", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga goto_definition]])
            else
                vim.lsp.buf.definition()
            end
        end, opts, "goto definition")

        if utils.has("lspsaga.nvim") then
            map("n", "<localleader>pd", function()
                vim.cmd([[Lspsaga peek_definition]])
            end, opts, "peek definition")
        end
    end
    if client.server_capabilities.typeDefinitionProvider then
        map("n", "<localleader>gt", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga goto_type_definition]])
            else
                vim.lsp.buf.type_definition()
            end
        end, opts, "goto type definition")

        if utils.has("lspsaga.nvim") then
            map("n", "<localleader>pt", function()
                vim.cmd([[Lspsaga peek_type_definition]])
            end, opts, "peek type definition")
        end
    end
    if client.server_capabilities.implementationProvider then
        map("n", "<localleader>gi", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga finder imp+def]])
            else
                vim.lsp.buf.implementation()
            end
        end, opts, "goto type implementation")
    end
    if client.server_capabilities.referencesProvider then
        map("n", "<localleader>gr", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga finder ref]])
            else
                vim.lsp.buf.references({})
            end
        end, opts, "goto type references")
    end
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_set_hl(0, "LspReferenceRead", {
            link = "DiffText",
        })
        vim.api.nvim_set_hl(0, "LspReferenceText", {
            link = "IncSearch",
        })
        vim.api.nvim_set_hl(0, "LspRefDiffTexterenceWrite", {
            link = "WildMenu",
        })
        local doc_highlight = augroup("lsp_document_highlight")
        local enable_highlight = function()
            autocmd({ "CursorHold", "CursorHoldI" }, {
                group = doc_highlight,
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            autocmd("CursorMoved", {
                group = doc_highlight,
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
        local disable_highlight = function()
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({
                buffer = bufnr,
                group = doc_highlight,
            })
        end
        map("n", "<localleader>uh", function()
            utils.toggle(
                "highlight",
                {},
                { enable_highlight, disable_highlight }
            )
            vim.b[vim.fn.bufnr()]["highlight"]()
        end, opts, "toggle document highlight")
    end
    if client.server_capabilities.documentSymbolProvider then
        map(
            "n",
            "<localleader>ds",
            vim.lsp.buf.document_symbol,
            opts,
            "document symbols"
        )
    end
    if client.server_capabilities.codeActionProvider then
        map({ "n", "v" }, "<localleader>ca", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga code_action]])
            else
                vim.lsp.buf.code_action()
            end
        end, opts, "code action")
    end
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<localleader>uf", function()
            utils.toggle("autoformat", { global = true })
            autocmd("BufWritePre", {
                group = augroup("LspFormat"),
                callback = function()
                    if vim.g["autoformat"] then
                        vim.lsp.buf.format({ async = true })
                    end
                end,
            })
        end, opts, "toggle autoformat")

        map("n", "<localleader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts, "range format buffer")
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        map("v", "<localleader>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts, "range format buffer")
    end
    if client.server_capabilities.renameProvider then
        map("n", "<localleader>rn", function()
            vim.lsp.buf.rename()
        end, opts, "rename symbol")

        if utils.has("lspsaga.nvim") then
            map("n", "<localleader>rnw", function()
                vim.cmd([[Lspsaga project_replace]])
            end, opts, "rename across workspace")
        end
    end
    if client.server_capabilities.callHierarchyProvider then
        map("n", "<localleader>ci", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga incoming_calls]])
            else
                vim.lsp.buf.incoming_calls()
            end
        end, opts, "incoming calls")
        map("n", "<localleader>co", function()
            if utils.has("lspsaga.nvim") then
                vim.cmd([[Lspsaga outgoing_calls]])
            else
                vim.lsp.buf.outgoing_calls()
            end
        end, opts, "outgoing calls")
    end
    if client.server_capabilities.workspaceSymbolProvider then
        map(
            "n",
            "<localleader>ws",
            vim.lsp.buf.workspace_symbol,
            opts,
            "list workspace symbols"
        )
    end

    map("n", "[d", function()
        if utils.has("lspsaga.nvim") then
            vim.cmd([[Lspsaga diagnostic_jump_prev]])
        else
            vim.diagnostic.goto_prev()
        end
    end, opts, "goto previous diagnostics")
    map("n", "]d", function()
        if utils.has("lspsaga.nvim") then
            vim.cmd([[Lspsaga diagnostic_jump_next]])
        else
            vim.diagnostic.goto_next()
        end
    end, opts, "goto next diagnostics")

    if utils.has("lspsaga.nvim") then
        map("n", "<localleader>wd", function()
            vim.cmd([[Lspsaga show_workspace_diagnostics]]) --can use ++normal to show in loclist
        end, opts, "workspace diagnostics")
        map("n", "<localleader>bd", function()
            vim.cmd([[Lspsaga show_buf_diagnostics]])
        end, opts, "workspace diagnostics")
        map("n", "<localleader>wo", function()
            vim.cmd([[Lspsaga outline]])
        end, opts, "workspace outline")
    end
    map("n", "<localleader>sl", vim.diagnostic.setloclist, opts, "set loclist")
    map("n", "<localleader>of", vim.diagnostic.open_float, opts, "open float")

    map("n", "<localleader>wf", function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, opts, "list workspace folders")
    map("n", "<localleader>rd", function()
        print(
            "Language server "
                .. (vim.lsp.buf.server_ready() and "is ready" or "is not ready")
        )
    end, opts, "check if lsp is ready")
end)
