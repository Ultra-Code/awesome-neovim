" open new split panes to right and below
set splitright
set splitbelow

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

