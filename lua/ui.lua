--Enable true colours in terminal
vim.o.termguicolors = true

vim.o.background = "dark"

-- Onedark colorscheme
require("onedark").setup({
    style = "deep", -- dark, darker, cool, deep, warm, warmer, light
})

require("onedark").load()

-- status line
require("plugrc/lualine")

-- buffer line
require("plugrc/bufferline")

-- Treesitter syntax highlighting
require("plugrc/treesitter")
