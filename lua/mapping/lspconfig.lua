require("utils")
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- map the following keys after the language server attaches to a buffer
-- See `:help vim.lsp.*` for documentation on any of the below functions
autocmd({ 'LspAttach' }, {
    callback = function(args)
        local opts = { buffer = args.buf }

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end
        if client.server_capabilities.signatureHelpProvider then
            map("n", "<localleader>k", vim.lsp.buf.signature_help, opts)
        end
        if client.server_capabilities.declarationProvider then
            map("n", "<localleader>gD", vim.lsp.buf.declaration, opts)
        end
        if client.server_capabilities.definitionProvider then
            map("n", "<localleader>gd", vim.lsp.buf.definition, opts)
        end
        if client.server_capabilities.typeDefinitionProvider then
            map("n", "<localleader>td", vim.lsp.buf.type_definition, opts)
        end
        if client.server_capabilities.implementationProvider then
            map("n", "<localleader>gi", vim.lsp.buf.implementation, opts)
        end
        if client.server_capabilities.referencesProvider then
            map("n", "<localleader>gr", vim.lsp.buf.references, opts)
        end
        if client.server_capabilities.documentHighlightProvider then
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_set_hl(0, "LspReferenceRead", {
                link = "DiffText"
            })
            vim.api.nvim_set_hl(0, "LspReferenceText", {
                link = "IncSearch"
            })
            vim.api.nvim_set_hl(0, "LspRefDiffTexterenceWrite", {
                link = "WildMenu"
            })
            local doc_highlight = augroup('lsp_document_highlight', {
                clear = false,
            })
            local enable_highlight = function()
                autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    group = doc_highlight,
                    buffer = bufnr,
                    callback = vim.lsp.buf.document_highlight,
                })
                autocmd('CursorMoved', {
                    group = doc_highlight,
                    buffer = bufnr,
                    callback = vim.lsp.buf.clear_references,
                })

            end
            local disable_highlight = function()
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                    buffer = bufnr,
                    group = doc_highlight
                })
            end
            map("n", "<localleader>dh", disable_highlight, opts)
            map("n", "<localleader>eh", enable_highlight, opts)
        end
        if client.server_capabilities.documentSymbolProvider then
            map("n", "<localleader>ds", vim.lsp.buf.document_symbol, opts)
        end
        if client.server_capabilities.codeActionProvider then
            map({ "n", "v" }, "<localleader>ca", vim.lsp.buf.code_action, opts)
        end
        if client.server_capabilities.documentFormattingProvider then
            map("n", "<localleader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end
        if client.server_capabilities.documentRangeFormattingProvider then
            map("v", "<localleader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end
        if client.server_capabilities.renameProvider then
            map("n", "<localleader>rn", vim.lsp.buf.rename, opts)
        end
        if client.server_capabilities.callHierarchyProvider then
            map("n", "<localleader>ci", vim.lsp.buf.incoming_calls, opts)
            map("n", "<localleader>co", vim.lsp.buf.outgoing_calls, opts)
        end
        if client.server_capabilities.workspaceSymbolProvider then
            map("n", "<localleader>ws", vim.lsp.buf.workspace_symbol, opts)
        end

        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)
        map("n", "<localleader>sl", vim.diagnostic.setloclist, opts)
        map('n', '<localleader>of', vim.diagnostic.open_float, opts)

        map("n", "<localleader>wf", function()
            vim.pretty_print(vim.lsp.buf.list_workspace_folders())
        end, opts)
        map("n", "<localleader>rd", function()
            print("Language server " .. (vim.lsp.buf.server_ready() and "is ready" or "is not ready"))
        end, opts)

    end,
})
