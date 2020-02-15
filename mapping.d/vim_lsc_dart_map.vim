"With the cursor on either a return statement (when it is the only statement
"in a method block) or on the => in a method definition, toggle between the
"two ways to write the method. If it is an expression body method (=>) convert
"to a block body ({} and a return) or vice versa

noremap <buffer> <leader>tr :DartToggleMethodBodyType<cr>
