"Recommended Syntax for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1  " auto open/close location list
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode="passive"
let g:syntastic_enable_signs=0

"Addition , experimental
" check also when just opened the file
let g:syntastic_check_on_open = 1

" syntastic checker for javascript.
"let g:syntastic_javascript_checkers = ['eslint']
" don't put icons on the sign column (it hides the vcs status icons of signify)
"let g:syntastic_enable_signs = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1

"Syntatic Python Linter Configuration
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_exec='python3 -m flake8'

"Syntastic C++ Linter Configuration
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'clang++-9'
let g:syntastic_cpp_compiler_options = '-std=c++17'
