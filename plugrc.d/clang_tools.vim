function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-10/clang-format.py
  py3f /usr/bin/run-clang-tidy-10.py -fix -fomart
endfunction
autocmd BufWritePre *.h,*.c,*.cpp,*.hpp call Formatonsave()
