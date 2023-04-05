-- local kind_icons = {
--   Text = " ",
--   Function = "",
--   Method = "",
--   Constructor = "",
--   Field = " ",
--   Variable = "﬚ ",
--   Class = "ﴯ",
--   Interface = "",
--   Module = " ",
--   Property = " ",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   EnumMember = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   Constant = " ",
--   Struct = " ",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }
-- -- options for vim.diagnostic.config()
-- diagnostics = {
--   underline = true,
--   update_in_insert = false,
--   virtual_text = { spacing = 4, prefix = "●" },
--   severity_sort = true,
-- },
-- -- options for vim.lsp.buf.format
-- -- `bufnr` and `filter` is handled by the LazyVim formatter,
-- -- but can be also overridden when specified
-- format = {
--   formatting_options = nil,
--   timeout_ms = nil,
-- },
-- -- icons / text used for a diagnostic
-- signs = {
--   error = "",
--   warning = "",
--   hint = "",
--   information = "",
--   other = "﫠",
-- },
return {
    -- icons used by other plugins
    icons = {
        diagnostics = {
            Error = " ",--🅴
            Warn = " ", --🆆
            Hint = " ", --🅸
            Info = " ", --🅷
        },
        git = {
            add          = { text = '│' }, --" ","▎"
            change       = { text = '!' }, --" ",
            delete       = { text = '_' }, --" ",""
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        kinds = {
            Array = " ",
            Boolean = " ",
            Class = " ",
            Color = " ",
            Constant = " ",
            Constructor = " ",
            Copilot = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Folder = " ",
            Function = " ",
            Interface = " ",
            Key = " ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Namespace = " ",
            Null = " ",
            Number = " ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            String = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = " ",
            Value = " ",
            Variable = " ",
        },
    },
    -- options from nvim_open_win()| vim.diagnostic.open_float()
    -- | vim.lsp.util.open_floating_preview()| vim.diagnostic.config()
    ---@type table
    diagnostics_options = {
        virtual_text = {
            severity = vim.diagnostic.severity.ERROR,
            source = "if_many",
        },
        float = {
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            focusable = false,
            focus = false,
            source = "if_many",
            -- "single": A single line box.
            -- "double": A double line box.
            -- "rounded": Like "single", but with rounded corners "╭"
            -- "solid": Adds padding by a single whitespace cell.
            -- "shadow": A drop shadow effect by blending with the
            -- "none": No border (default).
            border = "shadow",
        },
        update_in_insert = false,
        severity_sort = true,
    }
}
