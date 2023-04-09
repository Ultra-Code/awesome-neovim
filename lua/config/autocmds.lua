local autocmd = vim.api.nvim_create_autocmd -- create autocmd
local map = vim.keymap.set
local utils = require("config.utils")

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
-- :h restore-position and :h restore-cursor
autocmd("BufReadPost", {
    group = augroup("restore cursor"),
    pattern = { "*" },
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 1 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

local function mdesc(opt, description)
    return vim.tbl_extend("force", opt, { desc = description })
end
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
        -- :help api-autocmd
        -- nvim_create_autocmd's callback receives a table argument with fields
        -- event = {id,event,group?,match,buf,file,data(arbituary data)}
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>",
            mdesc({ buffer = event.buf, silent = true }, "close some filetype windows with <q>"))
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
autocmd({ "CursorHold" }, {
    callback = function()
        vim.diagnostic.open_float(nil, diagnostics_options.float)
    end
})

-- Remove Trailing whitespaces in all files
autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]] })

-- map the following keys after the language server attaches to a buffer
-- See `:help vim.lsp.*` for doc mentation on any of the below functions
utils.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    if client.server_capabilities.hoverProvider then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, mdesc(opts,"get hover info"))
    end
    if client.server_capabilities.signatureHelpProvider then
        map("n", "<localleader>k", vim.lsp.buf.signature_help, mdesc(opts, "get fn signature help"))
        map("i", "<localleader>K", vim.lsp.buf.signature_help, mdesc(opts, "get fn signature help"))
    end
    if client.server_capabilities.declarationProvider then
        map("n", "<localleader>gD", vim.lsp.buf.declaration, mdesc(opts, "goto buffer declaration"))
    end
    if client.server_capabilities.definitionProvider then
        map("n", "<localleader>gd",
            function()
                if package.loaded["trouble"] then
                    vim.cmd [[Trouble lsp_definitions]]
                else
                    vim.lsp.buf.definition()
                end
            end
            , mdesc(opts, "goto buffer definition"))
    end
    if client.server_capabilities.typeDefinitionProvider then
        map("n", "<localleader>td",
            function()
                if package.loaded["trouble"] then
                    vim.cmd [[Trouble lsp_type_definitions]]
                else
                    vim.lsp.buf.type_definition()
                end
            end
            , mdesc(opts, "goto type definition"))
    end
    if client.server_capabilities.implementationProvider then
        map("n", "<localleader>gi",
            function()
                if package.loaded["trouble"] then
                    vim.cmd [[Trouble lsp_implementations]]
                else
                    vim.lsp.buf.implementation()
                end
            end,
            mdesc(opts, "goto type implementation"))
    end
    if client.server_capabilities.referencesProvider then
        map("n", "<localleader>gr",
            function()
                if package.loaded["trouble"] then
                    vim.cmd [[Trouble lsp_references]]
                else
                    vim.lsp.buf.references({})
                end
            end
            , mdesc(opts, "goto type references"))
    end
    if client.server_capabilities.documentHighlightProvider then
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
        map("n", "<localleader>uh", function()
            utils.toggle("highlight", true, { enable_highlight, disable_highlight })
            vim.b[vim.fn.bufnr()]["highlight"]()
        end, mdesc(opts, "toggle document highlight"))
    end
    if client.server_capabilities.documentSymbolProvider then
        map("n", "<localleader>ds", vim.lsp.buf.document_symbol, mdesc(opts, "document symbols"))
    end
    if client.server_capabilities.codeActionProvider then
        map({ "n", "v" }, "<localleader>ca", vim.lsp.buf.code_action, mdesc(opts, "code action"))
    end
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<localleader>uf", function()
            utils.toggle("autoformat", true)
            autocmd("BufWritePre", {
                group = augroup("LspFormat"),
                callback = function()
                    if vim.b[vim.fn.bufnr()]["autoformat"] then
                        vim.lsp.buf.format({ async = true })
                    end
                end,
            })
        end, mdesc(opts, "toggle autoformat"))

        map("n", "<localleader>f", function()
            vim.lsp.buf.format({ async = true })
        end, mdesc(opts, "range format buffer"))
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        map("v", "<localleader>f", function()
            vim.lsp.buf.format({ async = true })
        end, mdesc(opts, "range format buffer"))
    end
    if client.server_capabilities.renameProvider then
        map("n", "<localleader>rn", vim.lsp.buf.rename, mdesc(opts, "rename symbol"))
    end
    if client.server_capabilities.callHierarchyProvider then
        map("n", "<localleader>ci", vim.lsp.buf.incoming_calls, mdesc(opts, "incoming calls"))
        map("n", "<localleader>co", vim.lsp.buf.outgoing_calls, mdesc(opts, "outgoing calls"))
    end
    if client.server_capabilities.workspaceSymbolProvider then
        map("n", "<localleader>ws", vim.lsp.buf.workspace_symbol, mdesc(opts, "list workspace symbols"))
    end

    map("n", "[d", vim.diagnostic.goto_prev, mdesc(opts, "goto previous diagnostics"))
    map("n", "]d", vim.diagnostic.goto_next, mdesc(opts, "goto next diagnostics"))
    map("n", "<localleader>sl", vim.diagnostic.setloclist, mdesc(opts, "set loclist"))
    map('n', '<localleader>of', vim.diagnostic.open_float, mdesc(opts, "open float"))

    map("n", "<localleader>wf", function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, mdesc(opts, "list workspace folders"))
    map("n", "<localleader>rd", function()
        print("Language server " .. (vim.lsp.buf.server_ready() and "is ready" or "is not ready"))
    end, mdesc(opts, "check if lsp is ready"))
end
)