require('utils')
map('n','<leader>mp','<Cmd>Glow<cr>')
vim.cmd[[
"autocmd! FileType markdown packadd glow.nvim
"command! Glow :packadd glow.nvim |:Glow
"command! -nargs=* Ack :packadd ack.vim | Ack <f-args>"
]]
