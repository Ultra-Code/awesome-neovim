function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/clang/clang-format-11/clang-format.py
endfunction
autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.cxx,*.hxx,*.tpp,*.txx call Formatonsave()
