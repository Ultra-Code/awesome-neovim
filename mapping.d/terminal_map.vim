" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction

"Mapping to open terminal emulator in nvim
nnoremap <c-t> :call OpenTerminal()<CR>
