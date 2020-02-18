"shows the errors inside a quickfix window, which will allow your to
"quickly jump to the error locations by simply pressing [Enter]
let g:flake8_show_in_file=1
"location of your flake8 binary
let g:flake8_cmd="~/.local/bin/flake8"
"To customize the height of quick fix window
let g:flake8_quickfix_height=7

"If you don't want to use the <F7> key for flake8-checking, simply remap it 
"to another key. It autodetects whether it has been remapped and won't register
"the <F7> key if so. For example, to remap it to <F3> instead, use
"autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>

"General variable for neovim python highlighting
let python_highlight_all=1
