" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "
"PLUG INS FOR NEOVIM
"Specify a directory for plugins
"-For Neovim: ~/.local/share/nvim/plugged
"To make config resuable system wide use absolute path instead eg.
"/home/$USER/.local/share/nvim/plugged
"-Avoid using standard Vim directory names like 'plugin'

call plug#begin('$HOME/.local/share/nvim/plugged')

" === Editor Plugins === "
"Multiple cursor editing
Plug 'terryma/vim-multiple-cursors'

" EasyMotion provides a mush simpler way to use motions in vim
Plug 'easymotion/vim-easymotion'

"A commenter for different Language
Plug 'scrooloose/nerdcommenter'

" === Themes and Colour Scheme ===
Plug 'rakr/vim-one'

" === Git Plugin ===
"A vim plugin which shows git diff in the gutter (sign column).
Plug 'airblade/vim-gitgutter'

"A git wrapper
Plug 'tpope/vim-fugitive'

"A plugin of NERDTree showing git status flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" === Satus Line ===
"Status bar plugin
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'

" === Source Code Formater ===
"A neoformat plugin for code formating
Plug 'sbdchd/neoformat'

" === Fuzzy Finder ===
"fzf is a general-purpose command-line fuzzy finder.
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.local/share/nvim/plugged/fzf/', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run the install script if you use fzf only in Vim.
Plug 'junegunn/fzf.vim'

" === Markdown Plugins ===
"Markdown Syntax Highlighting"
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"A markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" === Language Specific Plugins ===

"Dart language support in vim
Plug 'dart-lang/dart-vim-plugin'

"TypeScript Language support in neovim and vim

"TypeScrip Syntax Highlighting
Plug 'HerringtonDarkholme/yats.vim'

"GraphQL This Vim plugin provides GraphQL file detection, syntax highlighting, and indentation.
Plug 'jparise/vim-graphql'

" == Code Completion Engine ===

"Coc is an intellisense engine for Vim/Neovim
"Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Code Snippets Plugins ===
"For snippets in neovim
" Track the engine.
Plug 'SirVer/ultisnips'

"Bootstrap snippets
Plug 'jvanja/vim-bootstrap4-snippets'

" Snippets are separated from the engine. Add this if you want them:
Plug   'honza/vim-snippets'

" === Syntax Highlighting Engine ===
"Syntastic is a syntax checking plugin for Vim
 Plug 'scrooloose/syntastic'

"A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" === Tag Bar Plugin ===
"View and search LSP symbols, tags in Vim/NeoVim."
Plug 'liuchengxu/vista.vim'

" === UI === "
" A Neovim File explorer
Plug 'preservim/nerdtree'

" == Icons == "
" Glyphs and Icons for neovim
Plug 'ryanoasis/vim-devicons'

" === DataBase ===
Plug 'tpope/vim-dadbod'

" Initialize plugin system
call plug#end()

