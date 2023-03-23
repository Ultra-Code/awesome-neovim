local autocmd = vim.api.nvim_create_autocmd -- create autocmd
local map = vim.keymap.set

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end


-- define autocmd in a group so that you can clear it easily
autocmd({ "TermOpen" }, {
    group = augroup("Terminal"),
    pattern = { "*" },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.api.nvim_command("startinsert")
    end,
})


-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("wincmd =")
        vim.cmd("tabdo wincmd =")
    end,
})

-- go to the last known loc/position when opening a file/buffer
autocmd("BufReadPost", {
    group = augroup("restor_cursor_last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>
autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query", -- :InspectTree
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown", "norg" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

local diagnostics_options = require("config.defaults").diagnostics_options
-- automatically show diagnostics on current line
autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
        vim.diagnostic.open_float(nil, diagnostics_options.float)
    end
})

-- Remove Trailing whitespaces in all files
autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]] })

--TODO: maybe make below a filetype plugin
autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.lua" },
    callback = function(ev)
        _ = ev
        -- :help api-autocmd
        -- nvim_create_autocmd's callback receives a table argument with fields
        -- ev = {id,event,group?,match,buf,file,data(arbituary data)}

        -- reload/source current file
        map("n", "<leader>r", function()
            vim.cmd([[luafile %]])
            print("reloaded " .. vim.fn.expand("%"))
        end, { buffer = true })

        -- reload a particular module
        map("n", "<leader>rm", function()
            local module_name = vim.fn.input({
                prompt = "\nEnter the name of the module you want to reload\n:",
                default = "",
                completion = "file",
                cancelreturn = "input cancelled",
            })
            if module_name == "" then
                return
            else
                reload(module_name)
                vim.notify("!Reloaded Nvim Module " .. module_name .. ".lua!", vim.log.levels.INFO)
            end
        end, { buffer = true })

        -- reload all nvim configuration modules
        map("n", "<leader>ra", function()
            reloadAllModules()
            vim.notify("!Reloaded All Nvim Modules!", vim.log.levels.INFO)
        end, { buffer = true })
    end
})

-- TODO: use utils.on_attach
-- map the following keys after the language server attaches to a buffer
-- See `:help vim.lsp.*` for doc mentation on any of the below functions
autocmd({ 'LspAttach' }, {
    callback = function(args)
        local opts = { buffer = args.buf }

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end
        if client.server_capabilities.signatureHelpProvider then
            map("n", "<localleader>k", vim.lsp.buf.signature_help, opts)
            map("i", "<localleader>K", vim.lsp.buf.signature_help, opts)
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
            local doc_highlight = augroup('lsp_document_highlight')
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
            --TODO: use utils.toggle for toggling document highlight
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
