local M = {}

--   漣        ﱮ
M.icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = "了 ",
    EnumMember = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Property = " ",
    Snippet = "﬌ ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = "﬚ ",
}

function M.completion_kinds()
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
        kinds[i] = M.icons[kind] or kind
    end
end

function M.sign_column_diagnostic_symbols()
    --    --  --   ﯧ   --    ﯦ
    local signs = {
        Error = " ",
        Warning = " ",
        Hint = " ",
        Information = " ",
    }
    for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

function M.disable_virtual_text()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            update_in_insert = false,
            signs = true,
            underline = true,
        }
    )
end
function M.display_diagnostics_sources()
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        function(_, _, params, client_id, _)
            local config = { -- your config
                virtual_text = false,
                update_in_insert = false,
                signs = true,
                underline = true,
            }
            local uri = params.uri
            local bufnr = vim.uri_to_bufnr(uri)

            if not bufnr then
                return
            end

            local diagnostics = params.diagnostics

            for i, v in ipairs(diagnostics) do
                diagnostics[i].message = string.format(
                    "%s: %s",
                    v.source,
                    v.message
                )
            end

            vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

            if not vim.api.nvim_buf_is_loaded(bufnr) then
                return
            end

            vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
        end
end

return M
