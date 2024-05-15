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
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = "Comments" },
            motions = {
                count = true,
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer/BufferLine" },
                ["<leader>d"] = { name = "+debugger" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui/toggle" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
                ["<leader>h"] = { name = "+gitsigns/hop" },
                ["<localleader>u"] = { name = "+toggle" },
            }
            wk.register(keymaps)
        end,
    },
}
