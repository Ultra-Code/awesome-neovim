--Enable true colours in terminal
vim.cmd[[set termguicolors]]

--Set the background color of nvim
vim.cmd[[set background=dark]]

--Default colorscheme
--colorscheme evening

--Onedark colorscheme
vim.g.onedark_style = 'deep' --darker,default,cool ,deep,warm,warmer
require('onedark').setup()
vim.cmd[[colorscheme onedark]]

--set guifont=SauceCodePro\ Nerd\ Font\ Medium\ 11
-- Set status line display
-- source $HOME/.config/nvim/plugrc.d/sexy_status_bar.vim
