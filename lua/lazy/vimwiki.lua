require('utils')
local opt = {noremap = false}

map('n','<leader>ww','[[<cmd>packadd vimwiki<cr>|<Plug>VimwikiIndex]]',opt)
