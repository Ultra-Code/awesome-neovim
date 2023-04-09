return {

    -- Onedark colorscheme
    {
        "navarasu/onedark.nvim",
        event = "BufEnter",
        config = function(_, opts)
            require("onedark").setup(opts)
            require("onedark").load()
        end,
        opts = {
            -- Main options --
            style = 'deep',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false,          -- Show/hide background
            term_colors = true,           -- Change terminal color as per the selected theme style
            ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
            -- toggle theme style ---
            toggle_style_key = nil,       -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            -- List of styles to toggle between
            toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },
            -- Lualine options --
            lualine = {
                transparent = false, -- lualine center bar transparency
            },
            -- Custom Highlights --
            colors = {},     -- Override default colors
            highlights = {}, -- Override highlight groups
            -- Plugins Config --
            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        }
    },
    -- Tabline
    -- A snazzy buffer line (with minimal tab integration) for Neovim
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            -- pick a buffer to view from the buffer list
            { "<leader>bs", "<cmd>BufferLinePick<CR>",      mode = "n", silent = true, },
            -- pick a buffer to closes from the buffer list
            { "<leader>bc", "<cmd>BufferLinePickClose<CR>", mode = "n", silent = true }
        },
        opts = {
            options = {
                numbers = function(opts)
                    return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
                end,
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                tab_size = 18,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left", --[[| "center" | "right",]]
                    },
                },
                show_buffer_icons = true,       --| false, -- disable filetype icons for buffers
                show_buffer_close_icons = true, --| false,
                show_close_icon = true,         --| false,
                show_tab_indicators = true,     --| false,
                persist_buffer_sort = true,     -- whether or not custom sorted buffers should persist
                -- can also be a table containing 2 custom separators
                -- [focused and unfocused]. eg: { '|', '|' }
                separator_style = "slant",     --| "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = false,  --| true,
                always_show_bufferline = true, --| false,
            },
        }
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local function total_num_lines()
                return vim.api.nvim_buf_line_count(0);
            end

            return {
                options = {
                    theme = "auto",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
                    lualine_b = { "branch", "diff" },
                    lualine_c = { {
                        "filename",
                        file_status = true, -- displays file status (readonly status, modified status)
                        path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
                    } },
                    lualine_x = { 'encoding', 'fileformat' },
                    lualine_y = { "filetype", total_num_lines },
                    lualine_z = {
                        { "location", separator = { right = "" }, left_padding = 2 },
                    },
                },
            }
        end,
    },
    -- === Syntax Plugins ===
    -- Nvim Treesitter configurations and abstraction layer
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        build = function()
            vim.cmd("TSUpdate")
        end,
        opts = {
            -- A list of parser names, or "all" (the 1st five listed parsers should always be installed)
            -- For web dev "jsonc", "typescript", "css", "html", "vue",
            ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp", "zig", "norg", "bash", "glsl" },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            ignore_install = {}, -- List of parsers to ignore installing
            highlight = {
                enable = true,   -- false will disable the whole extension
                disable = {},    -- list of language that will be disabled
            },
            --Incremental selection based on the named nodes from the grammar.
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            --Indentation based on treesitter for the = operator.
            indent = {
                enable = true,
            },
            autopairs = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
