" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"a more automatic behavior where when cursoring over a word,
"You see either the diagnostic if it exists, otherwise the documentation
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(3000, 'ShowDocIfNoDiagnostic')
endfunction

augroup hover_doc
  autocmd!
    "autocmd CursorHoldI * :call <SID>show_hover_doc()
    "autocmd CursorHold * :call <SID>show_hover_doc()
augroup end

augroup reference_signature
  autocmd!
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = [
  \ 'coc-syntax',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-pairs',
  \ 'coc-json',
  \ 'coc-eslint',
  \ 'coc-emmet',
  \ 'coc-yaml',
  \ 'coc-vetur',
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-markdownlint',
  \ 'coc-html',
  \ 'coc-css',
  \'coc-stylelint'
  \ ]
