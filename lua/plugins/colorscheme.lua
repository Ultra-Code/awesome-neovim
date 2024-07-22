return {
    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        -- event = {"BufReadPre","BufNewFile"},
        opts = {
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            background = {
                -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            show_end_of_buffer = false, -- show the '~' characters after the end of buffers
            term_colors = true,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            -- custom_highlights = function(colors) -- Global highlight, will be replaced with custom_highlights if exists
            --     return {
            --         -- Comment = { fg = colors.peach, style = { "italic" } },
            --         -- ["@field"] = { fg = colors.blue },
            --     }
            -- end,
            -- For more plugins integrations (https://github.com/catppuccin/nvim#integrations)
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = true,
                hop = true,
                markdown = true,
                noice = true,
                treesitter = true,
                symbols_outline = true,
                lsp_trouble = true,
                which_key = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    -- Onedark colorscheme
    {
        "navarasu/onedark.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function(_, opts)
            require("onedark").setup(opts)
            require("onedark").load()
        end,
        opts = {
            -- Main options --
            style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false, -- Show/hide background
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
            -- toggle theme style ---
            toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            -- List of styles to toggle between
            toggle_style_list = {
                "dark",
                "darker",
                "cool",
                "deep",
                "warm",
                "warmer",
                "light",
            },
            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = "italic",
                keywords = "none",
                functions = "none",
                strings = "none",
                variables = "none",
            },
            -- Lualine options --
            lualine = {
                transparent = false, -- lualine center bar transparency
            },
            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {}, -- Override highlight groups
            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        },
    },
}
