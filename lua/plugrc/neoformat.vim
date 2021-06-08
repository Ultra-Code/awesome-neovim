" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

"Only dispaly message if there is an error
let g:neoformat_only_msg_on_error = 1

let g:neoformat_python_yapf = {
            \ 'exe': 'yapf',
            \ 'args': [],
            \ 'replace': 0,
            \ 'stdin': 1,
            \ 'valid_exit_codes': [0, 23],
            \ 'no_append': 1,
            \ }
let g:neoformat_cpp_clangformat={
            \ 'exe':'clang-format',
            \ 'args': ['-style=file'],
            \ 'stdin':1,
            \}
let g:neoformat_nix_nixfmt = {
            \ 'exe': 'nixfmt',
            \ 'args': ["--width=80" ,"--check"],
            \ 'replace': 0,
            \ 'stdin': 1,
            \}
let g:neoformat_cmakelists_cmakeformat = {
            \'exe':'cmake-format',
            \}
" replace - replace the file, instead of updating buffer (default: 0),
" stdin - send data to stdin of formatter (default: 0),
let g:neoformat_enabled_python = ['yapf']

"Haskell code formatter
let g:neoformat_enabled_haskell= ['hindent']

let g:neofomat_enabled_cpp=['clangformat']

augroup fmt
  autocmd!
  autocmd BufWritePre *.hs,*.py,*.nix,CMakeLists.txt | Neoformat
augroup END
