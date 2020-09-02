function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-11/clang-format.py
endfunction
autocmd BufWritePre *.h,*.c,*.cpp,*.hpp call Formatonsave()
