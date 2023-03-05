local function total_num_lines()
    return vim.api.nvim_buf_line_count(0);
end

require("lualine").setup({
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
})
