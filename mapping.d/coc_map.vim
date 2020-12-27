" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"Map <tab> for trigger completion, completion confirm, snippet expand and jump like VSCode

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"Note: the `coc-snippets` extension is required for this to work.
let g:coc_snippet_next = '<tab>'

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"Setup Prettier command in your init.vim or .vimrc
"So you can use :Prettier to format current buffer.
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"Then your can <leader>f for range format.Prettier range format only support
"languageId including: javascript, javascriptreact, typescript, typescriptreact,
"json and graphql
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-line)
nmap <leader>a  <Plug>(coc-codeaction-line)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"Do command from codeLens of current line
nmap <leader>cdl <Plug>(coc-codelens-action)

"Open refactor window for refactor of current symbol.
nmap <leader>r <Plug>(coc-refactor)

"Open link under cursor
nmap <leader>ol <Plug>(coc-openlink)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" Use <C-s> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
nmap <silent> <S-s> <Plug>(coc-range-select-backword)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>r  :<C-u>CocListResume<CR>

