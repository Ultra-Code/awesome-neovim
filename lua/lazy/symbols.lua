require("utils")

local function symbols_setup()
    vim.cmd([[ packadd symbols-outline.nvim ]])

    local symbols_outline_opts = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = { "jk", "q" },
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "p",
            rename_symbol = "r",
            code_actions = "a",
            fold = "zf",
            unfold = "zu",
            fold_all = "zC",
            unfold_all = "zO",
            fold_reset = "zR",
        },
    }
    require("symbols-outline").setup(symbols_outline_opts)
end

map(
    "n",
    "<leader>so",
    function()
        symbols_setup()
        vim.cmd([[SymbolsOutline]])
    end,
    { silent = true }
)
