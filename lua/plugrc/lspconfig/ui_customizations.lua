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
        local hl = "DiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return M