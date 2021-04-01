augroup detectfiletypes
  autocmd! BufRead,BufNewFile *.mxx,*.mpp,*.txx,*.tpp setfiletype cpp
augroup END

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.pdc set filetype=markdown.pandoc
augroup END

augroup build2_syntax
    au! BufNewFile,BufFilePre,BufRead buildfile set filetype=make
augroup END
