-- Check docs :h vimwiki-list
vim.cmd[[
autocmd FileType vimwiki inoremap <silent><buffer> <CR>  <C-]><Esc>:VimwikiReturn 3 3<CR>
autocmd FileType vimwiki inoremap <silent><buffer> <S-CR>  <Esc>:VimwikiReturn 2 2<CR>
]]
