--Enable true colours in terminal
vim.o.termguicolors = true

-- Onedark colorscheme
require("onedark").setup({
    style = "dark", -- dark, darker, cool, deep, warm, warmer, light
})

require("onedark").load()

-- status line
require("plugrc/lualine")

-- buffer line
require("plugrc/bufferline")

-- Treesitter syntax highlighting
require("plugrc/treesitter")
