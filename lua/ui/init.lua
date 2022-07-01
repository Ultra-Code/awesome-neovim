--Enable true colours in terminal
vim.o.termguicolors = true

vim.o.background = "dark"

-- colour scheme
require("ui.onedark")

-- status line
require("ui.lualine")

-- buffer line
require("ui.bufferline")

-- Treesitter syntax highlighting
require("ui.treesitter")
