function! Formatonsave()
  let l:formatdiff = 1
  py3f /usr/share/vim/addons/syntax/clang-format.py
endfunction
autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.cxx,*.hxx,*.tpp,*.txx call Formatonsave()
