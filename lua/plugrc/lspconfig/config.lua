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
            update_in_insert = true,
            signs = true,
            underline = true,
        }
    )
end

return M
