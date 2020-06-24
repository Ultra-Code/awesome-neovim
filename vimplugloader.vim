"Vim-plug Install and related settings

" Auto-install vim-plug on different systems if it does not exist. For
" The following script to install vim-plug is adapted from vim-plug
" wiki: https://github.com/junegunn/vim-plug/wiki/tips#tips

"if executable('curl')
    "if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        "silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        "\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    "endif

if executable('curl')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        echomsg 'Installing Vim-plug on your system'
        silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs '
            \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        augroup plug_init
            autocmd!
            autocmd VimEnter * PlugInstall --sync | quit |source $MYVIMRC
        augroup END
    endif
else
    echoerr 'You have to install curl to install vim-plug, or install '
            \ . 'vim-plug by yourself.'
    finish
endif
