-- open new split panes to right and below
vim.cmd[[set splitright]]
vim.cmd[[set splitbelow]]

--hide line numbers in terminal windows
vim.cmd[[au BufEnter term://* setlocal nonumber]]

--Always start terminal in insert mode
vim.cmd[[autocmd TermOpen * startinsert]]
