-- open new split panes to right and below
vim.go.splitright = true
vim.go.splitbelow = true
vim.cmd [[
  augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <c-q> <c-\><c-n>:bd!<cr>
    au TermOpen * startinsert
    au TermOpen * set nonumber
  augroup end
]]
