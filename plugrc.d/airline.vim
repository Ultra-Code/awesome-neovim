"Enable powerline fonts symbols
let g:airline_powerline_fonts=1

"enable caching of the various syntax highlighting groups.
"And use :AirlineRefresh to clear the cache
let g:airline_highlighting_cache = 1

"Set terminal color to 256 colors
set t_Co=256

"Enable tabline extention
let g:airline#extensions#tabline#enabled = 1

"Separators can be configured independently for the tabline,
"so here is how you can define "straight" tabs
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

"In addition, you can also choose which path formatter airline uses.
"This affects how file paths are displayed in each individual tab as
"well as the current buffer indicator in the upper right. To do so,
"set the formatter field with

let g:airline#extensions#tabline#formatter = 'unique_tail'

" AIRLINE SETTINGS
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_skip_empty_sections = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#syntastic#enabled = 1
let g:airline_detect_iminsert=1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#wordcount#enabled = 0
"let g:airline_theme='base16'
let g:airline#extensions#tagbar#enabled = 1
" END AIRLINE SETTINGS
