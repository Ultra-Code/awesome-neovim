"Recommended Syntax for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Syntatic Python Linter Configuration
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = ""

"Syntastic C++ Linter Configuration
let g:syntastic_aggregate_errors = 1 "display all errors from all checkers together"
let g:syntastic_cpp_checkers = ['cppcheck']
"checker args
let g:syntastic_cpp_cppcheck_args="--enable=warning,style,performance,portability,information,missingInclude --inconclusive --force -j 4 --template=gcc --language=c++"
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++20'
let g:syntastic_cpp_check_header = 0 "change to 0"

"fill the |location-list| with the errors found by the checkers"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1  " auto open/close location list
let g:syntastic_check_on_open = 0  " check also when just opened the file
let g:syntastic_check_on_wq = 0    " check when ever buffers are written to disk"

let b:syntastic_mode="active"
let g:syntastic_enable_signs = 1

" syntastic checker for javascript.
"let g:syntastic_javascript_checkers = ['eslint']
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = 's>'
let g:syntastic_style_warning_symbol = 'sw'

"Let syntastic enable ballons ie.popups for error messages
let g:syntastic_enable_balloons =1 "Enable or Disable ballons"
