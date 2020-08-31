" turn terminal to normal mode with escape
"tnoremap <Esc> <C-\><C-n>:q<CR>

" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction

"Mapping to open terminal emulator in nvim
nnoremap <c-t> :call OpenTerminal()<CR>
