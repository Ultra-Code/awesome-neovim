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

"A commenter for different Language
Plug 'scrooloose/nerdcommenter'

" === Themes and Colour Scheme ===

Plug 'danilo-augusto/vim-afterglow'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" === Git Plugin ===

"A vim plugin which shows git diff in the gutter (sign column).
Plug 'airblade/vim-gitgutter'

"A plugin of NERDTree showing git status flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" === Satus Line ===

"Status bar plugin
 Plug 'vim-airline/vim-airline'

" === Source Code Formater ===

"A neoformat plugin for code formating
Plug 'sbdchd/neoformat'

" === Fuzzy Finder ===

"fzf is a general-purpose command-line fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" === Markdown Plugins ===

"Markdown Syntax Highlighting"
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"A markdown previewer prebuild binary
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"Pandoc Markdown
Plug 'vim-pandoc/vim-pandoc-syntax'

"Vim Wiki
Plug 'vimwiki/vimwiki'

" === Language Specific Plugins ===


" == Code Completion Engine ===

"Coc is an intellisense engine for Vim/Neovim
"Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Code Snippets Plugins ===


" === Syntax Highlighting Engine ===

"Syntastic is a syntax checking plugin for Vim
Plug 'scrooloose/syntastic'

"A collection of language syntax packs for Vim.
Plug 'sheerun/vim-polyglot'

" === Tag Bar Plugin ===

"View and search LSP symbols, tags in Vim/NeoVim."
Plug 'liuchengxu/vista.vim'

" === UI === "

" A Neovim File explorer
Plug 'preservim/nerdtree'

" == Icons == "

" Glyphs and Icons for neovim
"Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

