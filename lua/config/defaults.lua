return {
    -- icons used by other plugins
    icons = {
        diagnostics = {
            Error = "", --🅴," "
            Warn = "", --🆆," "
            Hint = "", --🅸," "
            Info = "", --🅷," ","﫠"
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
            Class = " ", --"ﴯ",
            Color = " ", --"",
            Constant = " ",
            Constructor = "",
            Copilot = " ",
            Enum = " ",
            EnumMember = "",
            Event = " ", --"",
            Field = " ",
            File = "",
            Folder = " ",
            Function = "",
            Interface = " ", --"",
            Keyword = "",
            Method = " ",
            Module = " ",
            Namespace = " ",
            Null = " ",
            Number = " ",
            Object = " ",
            Operator = " ", --"",
            Package = " ",
            Property = " ", --" ",
            Reference = " ", --"",
            Snippet = " ",
            String = " ",
            Struct = " ", --" ",
            Text = " ", --" ",
            TypeParameter = " ",
            Unit = " ", --"",
            Value = "",
            Variable = "﬚ ",
        },
    },
    -- options from nvim_open_win()| vim.diagnostic.open_float()
    -- | vim.lsp.util.open_floating_preview()| vim.diagnostic.config()
    ---@type table
    diagnostics_options = {
        virtual_text = {
            severity = { min = vim.diagnostic.severity.INFO, max = vim.diagnostic.severity.WARN },
            source = "if_many", -- prefix = "●"
        },
        float = {
            relative = "mouse",
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
