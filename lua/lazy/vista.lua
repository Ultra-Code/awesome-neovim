require('utils')

local g=vim.g

g.vista_sidebar_width=40
g.vista_echo_cursor_strategy='floating_win'
map('n','<leader>vt','<cmd>packadd vista.vim<cr>|<cmd>Vista!!<cr>',{silent=true})
