-- open new split panes to right and below
vim.go.splitright = true
vim.go.splitbelow = true
vim.cmd([[
  augroup Terminal
    autocmd!
    au TermOpen * startinsert
    au TermOpen * set nonumber
    au TermOpen * set norelativenumber
  augroup end
]])
