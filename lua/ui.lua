--Enable true colours in terminal
vim.o.termguicolors = true

--Set the background color of nvim
vim.o.background = 'dark'

--Onedark colorscheme
vim.g.onedark_style = 'deep' --darker,default,cool ,deep,warm,warmer
require('onedark').setup()
vim.cmd[[colorscheme onedark]]

-- Treesitter syntax highlighting
require('plugrc/treesitter')

-- status line
require('plugrc/lualine')

-- buffer line
require("plugrc/bufferline")

