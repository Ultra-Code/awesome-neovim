return {
    -- Tabline
    -- A snazzy buffer line (with minimal tab integration) for Neovim
    {
        "akinsho/bufferline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            -- pick a buffer to view from the buffer list
            { "<leader>bs", "<cmd>BufferLinePick<CR>", desc = "select buffer" },
            -- pick a buffer to closes from the buffer list
            {
                "<leader>bc",
                "<cmd>BufferLinePickClose<CR>",
                desc = "close selected buffer",
            },
            {
                "<leader>bcl",
                "<cmd>BufferLineCloseLeft<CR>",
                desc = "close buffers to the left",
            },
            {
                "<leader>bcr",
                "<cmd>BufferLineCloseRight<CR>",
                desc = "close buffers to the right",
            },
            {
                "<leader>bcu",
                "<cmd>BufferLineGroupClose ungrouped<CR>",
                desc = "close ungrouped buffers",
            },
            {
                "<leader>bcp",
                "<cmd>BufferLineGroupClose pinned<CR>",
                desc = "close pinned buffers",
            },
            {
                "<leader>bp",
                "<Cmd>BufferLineTogglePin<CR>",
                desc = "Toggle pin",
            },
            {
                "<leader>bP",
                "<Cmd>BufferLineGroupToggle pinned<CR>",
                desc = "Toggle displaying pinned buffers",
            },
            {
                "<leader>bU",
                "<Cmd>BufferLineGroupToggle ungrouped<CR>",
                desc = "Toggle displaying ungrouped buffers",
            },
        },
        opts = {
            options = {
                numbers = function(opts)
                    return string.format(
                        "%s|%s",
                        opts.id,
                        opts.raise(opts.ordinal)
                    )
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
                diagnostics_indicator = function(
                    count,
                    level,
                    diagnostics_dict,
                    context
                )
                    _ = context
                    _ = diagnostics_dict
                    local icon = level:match("error") and " "
                        or (level:match("warning") and " " or "")
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
                                return buf.name:match("%_test")
                                    or buf.name:match("%_spec")
                            end,
                        },
                        {
                            name = "Docs",
                            highlight = { undercurl = true, sp = "green" },
                            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                            matcher = function(buf)
                                return buf.name:match("%.md")
                                    or buf.name:match("%.txt")
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
                    theme = "onedark", -- "auto", "catppuccin",
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        {
                            "mode",
                            separator = { left = "" },
                            right_padding = 2,
                        },
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
                        {
                            "location",
                            separator = { right = "" },
                            left_padding = 2,
                        },
                    },
                },
            }
        end,
    },
}
