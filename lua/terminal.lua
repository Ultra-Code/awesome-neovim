-- open new split panes to right and below
vim.cmd[[set splitright]]
vim.cmd[[set splitbelow]]

vim.cmd [[
  augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>:q<cr>
    au TermOpen * startinsert
    au TermOpen * set nonumber
  augroup end
]]
