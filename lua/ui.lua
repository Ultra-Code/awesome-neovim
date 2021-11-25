--Enable true colours in terminal
vim.o.termguicolors = true

-- Onedark colorscheme
vim.g.onedark_style = "deep" --darker,default,cool ,deep,warm,warmer

require("onedark").setup()
-- For dark theme
--vim.g.vscode_style = "dark"
--
--vim.cmd[[colorscheme vscode]]
-- status line
require("plugrc/lualine")

-- buffer line
require("plugrc/bufferline")

-- Treesitter syntax highlighting
require("plugrc/treesitter")
