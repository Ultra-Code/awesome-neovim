-- every spec file under config.plugins will be loaded automatically by lazy.nvim
return {

    -- auto pairs
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
        end,
    },
    -- comments
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require("Comment").setup(opts)
        end,
    },
    -- library used by other plugins
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true }, -- Glyphs and Icons for neovim

    -- todo comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        cmd = { "TodoTelescope", "TodoLocList" },
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>tt", "<cmd>TodoTelescope<cr>",                            desc = "List Todo in Telescope" },
            { "<leader>tl", "<cmd>TodoLocList<cr>",                            desc = "List Todo in LocList" },
        },
    },
    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>b", group = "buffer/BufferLine" },
                    { "<leader>c", group = "code" },
                    { "<leader>d", group = "debugger" },
                    { "<leader>f", group = "file/find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gh", group = "hunks" },
                    { "<leader>h", group = "gitsigns/hop" },
                    { "<leader>q", group = "quit/session" },
                    { "<leader>s", group = "search" },
                    { "<leader>u", group = "ui/toggle" },
                    { "<leader>w", group = "windows" },
                    { "<leader>x", group = "diagnostics/quickfix" },
                    { "<localleader>u", group = "toggle" },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gz", group = "surround" },
                },
            },
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true, -- adds help for operators like d, y, ...
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
        end,
    },
}
