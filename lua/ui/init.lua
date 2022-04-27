--Enable true colours in terminal
vim.o.termguicolors = true

vim.o.background = "dark"

-- Onedark colorscheme
require("onedark").setup({
    style = "deep", -- dark, darker, cool, deep, warm, warmer, light
})

require("onedark").load()

-- status line
require("ui/lualine")

-- buffer line
require("ui/bufferline")

-- Treesitter syntax highlighting
require("ui/treesitter")
