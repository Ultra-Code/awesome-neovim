return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = "󰊳 Update",
                        group = "@property",
                        action = "Lazy update",
                        key = "u",
                    },
                    {
                        icon = " ",
                        icon_hl = "@variable",
                        desc = "Files",
                        group = "Label",
                        action = "Telescope find_files",
                        key = "f",
                    },
                    {
                        desc = " Apps",
                        group = "DiagnosticHint",
                        action = "Telescope app",
                        key = "a",
                    },
                    {
                        desc = " dotfiles",
                        group = "Number",
                        action = "Telescope dotfiles",
                        key = "d",
                    },
                },
            },
        },
    },
    -- {
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     config = function()
    --         require("alpha").setup(require("alpha.themes.dashboard").config)
    --     end,
    -- },
    -- Dashboard. This runs when neovim starts, and is what displays
    -- the "LAZYVIM" banner.
    -- {
    --     "goolord/alpha-nvim",
    --     event = "VimEnter",
    --     opts = function()
    --         local dashboard = require("alpha.themes.dashboard")
    --         local logo = [[
    --         ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    --         ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    --         ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    --         ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    --         ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    --         ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    --         ]]
    --
    --         dashboard.section.header.val = vim.split(logo, "\n")
    --         dashboard.section.buttons.val = {
    --             dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    --             dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    --             dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
    --             dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
    --             dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    --             dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    --         }
    --
    --         for _, button in ipairs(dashboard.section.buttons.val) do
    --             button.opts.hl = "AlphaButtons"
    --             button.opts.hl_shortcut = "AlphaShortcut"
    --         end
    --         dashboard.section.header.opts.hl = "AlphaHeader"
    --         dashboard.section.buttons.opts.hl = "AlphaButtons"
    --         dashboard.section.footer.opts.hl = "AlphaFooter"
    --         dashboard.opts.layout[1].val = 8
    --         return dashboard
    --     end,
    --     config = function(_, dashboard)
    --         -- close Lazy and re-open when the dashboard is ready
    --         if vim.o.filetype == "lazy" then
    --             vim.cmd.close()
    --             vim.api.nvim_create_autocmd("User", {
    --                 pattern = "AlphaReady",
    --                 callback = function()
    --                     require("lazy").show()
    --                 end,
    --             })
    --         end
    --
    --         require("alpha").setup(dashboard.opts)
    --
    --         vim.api.nvim_create_autocmd("User", {
    --             pattern = "LazyVimStarted",
    --             callback = function()
    --                 local stats = require("lazy").stats()
    --                 local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    --                 table.insert(
    --                     dashboard.section.header.val,
    --                     #dashboard.section.header.val + 1,
    --                     "\t\t\t\t⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    --                 )
    --                 pcall(vim.cmd.AlphaRedraw)
    --             end,
    --         })
    --     end,
    -- },
    -- indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },

    -- active indent guide and indent text objects
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    -- better vim.ui
    { "MunifTanjim/nui.nvim", lazy = true },
    -- Better `vim.notify()`
    {
        "rcarriga/nvim-notify",
        lazy = true,
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Clear notifications",
            },
        },
        opts = { timeout = 3000 },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                },
                override = {
                    -- override the default lsp markdown formatter with Noice
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    -- override the lsp markdown formatter with Noice
                    ["vim.lsp.util.stylize_markdown"] = true,
                    -- override cmp documentation with Noice (needs the other options to work)
                    ["cmp.entry.get_documentation"] = true,
                },
                --NOTE: install parsers for markdown and markdown_inline to see markdown documentation
                hover = {
                    enabled = true,
                },
                signature = {
                    enabled = false,
                },
                message = {
                    enabled = true, -- Messages shown by lsp servers
                },
            },
            health = {
                checker = false, -- Disable if you don't want health checks to run
            },
            presets = {
                -- you can enable a preset by setting it to true, or a table that will override the preset config
                -- you can also add custom presets that you can enable/disable with enabled=true
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = false, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
    },
    -- Tabline
    -- A snazzy buffer line (with minimal tab integration) for Neovim
    {
        "akinsho/bufferline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            -- pick a buffer to view from the buffer list
            { "<leader>bs", "<cmd>BufferLinePick<CR>", desc = "select buffer" },
            -- pick a buffer to closes from the buffer list
            { "<leader>bc", "<cmd>BufferLinePickClose<CR>", desc = "close selected buffer" },
            { "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>", desc = "close buffers to the left" },
            { "<leader>bcr", "<cmd>BufferLineCloseRight<CR>", desc = "close buffers to the right" },
            { "<leader>bcu", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "close ungrouped buffers" },
            { "<leader>bcp", "<cmd>BufferLineGroupClose pinned<CR>", desc = "close pinned buffers" },
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupToggle pinned<CR>", desc = "Toggle displaying pinned buffers" },
            { "<leader>bU", "<Cmd>BufferLineGroupToggle ungrouped<CR>", desc = "Toggle displaying ungrouped buffers" },
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
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
                show_buffer_icons = true, --| false, -- disable filetype icons for buffers
                show_buffer_close_icons = true, --| false,
                show_close_icon = true, --| false,
                show_tab_indicators = true, --| false,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                -- can also be a table containing 2 custom separators
                -- [focused and unfocused]. eg: { '|', '|' }
                separator_style = "slant", --| "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = false, --| true,
                always_show_bufferline = true, --| false,
                diagnostics = "nvim_lsp",
                --- count is an integer representing total count of errors
                --- level is a string "error" | "warning"
                --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
                --- this should return a string
                --- Don't get too fancy as this function will be executed a lot
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    _ = context
                    _ = diagnostics_dict
                    local icon = level:match("error") and " " or (level:match("warning") and " " or "")
                    return " " .. icon .. count
                end,
                groups = {
                    options = {
                        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
                    },
                    items = {
                        {
                            name = "Tests", -- Mandatory
                            highlight = { underline = true, sp = "blue" }, -- Optional
                            priority = 2, -- determines where it will appear relative to other groups (Optional)
                            icon = "", -- Optional
                            matcher = function(buf) -- Mandatory
                                return buf.name:match("%_test") or buf.name:match("%_spec")
                            end,
                        },
                        {
                            name = "Docs",
                            highlight = { undercurl = true, sp = "green" },
                            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                            matcher = function(buf)
                                return buf.name:match("%.md") or buf.name:match("%.txt")
                            end,
                            separator = { -- Optional
                                -- style = require('bufferline.groups').separator.tab
                            },
                        },
                    },
                },
            },
        },
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            local function total_num_lines()
                return vim.api.nvim_buf_line_count(0)
            end

            return {
                options = {
                    theme = "catppuccin", -- "onedark" "auto",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
                    lualine_b = { "branch", "diff" },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                        },
                    },
                    lualine_x = { "encoding", "fileformat" },
                    lualine_y = { "filetype", total_num_lines },
                    lualine_z = {
                        { "location", separator = { right = "" }, left_padding = 2 },
                    },
                },
            }
        end,
    },
}
