" Remap leader key to ,
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "."

" Use Unix as the standard file type
set ffs=unix,dos,mac

set encoding=UTF-8

" == Python provider configurations == "
let g:python3_host_prog='/usr/bin/python3'

"enable loading the plugin files for specific file types
filetype plugin indent on

"Switch on syntax highlighting.
syntax on

"set assembly language file to use nasm
let g:asmsyntax = "nasm"

"Set clipboard to the + and * registers
if has('clipboard')
     set clipboard+=unnamedplus,unnamed
endif

"Restore cursor to file position in previous editing session
"This autocommand jumps to the last known position in a file
"just after opening it, if the '" mark is set: >
:au BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

"Keep a backup copy of a file when overwriting it.This also sets the 'undofile' option, if
"available.  This will store the multi-level undo information in a file.  The result is
"that when you change a file, exit Vim, and then edit the file again, you can undo
"the changes made previously.
if has("vms")
    set nobackup
else
    set backup
    if has('persistent_undo')
        set undofile
        set undolevels=30000
        set undoreload=30000
    endif
endif

"for vim's swap ; undo and backup organization
set backupdir=/tmp//   "Location for backup of files before editing "
set directory=/tmp//   "The location of swap files ,ie buffers that have not been save ie in memory
set undodir=/tmp//     "Location for storing undo tree of the edited file"
set backupext=.vimbak  "The extension to be used for vim backup files


"Do not keep a backup or .swp file. I don't like to have junk
"files, my source is anyway in cvs/svn/p4/git.
set backup         " create a backup of the file before editing
set undofile       " enable undofile , which helps you undo a lot and redo also a lot
set noswapfile     " enable saving unsaved/unwritten files in a *.swp file

set nocompatible   " Use Vim defaults (much better!), Vi is for 70's programmers!

set expandtab      " always expands tab to spaces. It is good when peers use different editor.

set wildmenu       "Display completion matches in a status line.  That is when you type <Tab>
                   "and there is more than one match.

set termguicolors  "Set true colours in terminal

set completeopt=menuone,preview,noinsert " Don't let autocomplete affect usual typing habits

set bs=2            " allow backspacing over everything in insert mode

set hidden          " This option allows you to switch between multiple buffers
                    "without saving a changed buffer

set mouse=""        " Automatically enable mouse usage

set mousehide       " Hide the mouse pointer while typing.

set incsearch       " highlight search string as search pattern is entered

set hlsearch         "disables last search hilighting

set number           " Show line numbers

set wrap             " Automatically wrap text that extends beyond the screen length.

set backspace=indent,eol,start " Fixes common backspace problems

set laststatus=2      " Status bar

set showbreak=>>>\ \ \    " Wrap-broken line prefix

set textwidth=79      " Line wrap (number of cols)

set showmatch         " Highlight matching brace

set complete+=kspell  "text complete with CTRL-N or CTRL-P

"set spell        " Enable spell-checking

set spelllang=en_us

set visualbell     "Use visual bell (no beeping)

set ignorecase      "Always case-insensitie

set smartcase     " Enable smart-case search

set autoindent      " Auto-indent new lines

set wildignorecase    "case insensitive auto completion

set shiftwidth=4      " Number of auto-indent spaces

set smartindent      " Enable smart-indent

set smarttab      " Enable smart-tabs

set softtabstop=4     " Number of spaces per Tab

set confirm      " Prompt confirmation dialogs

set ruler             " Show row and column ruler information

set cmdheight=2       "Command line height

set autowriteall      "Auto-write all file changes

set history=10000       "Set the history size to maximum. by default it is 20

set list          " Display unprintable characters f12 - switches

set listchars=tab:••\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping


" Enable folding
set foldmethod=indent
set foldlevel=99

"Enable Tags
set tags=tags

"Remove Trailing whitespaces in all files
autocmd BufWritePre * %s/\s\+$//e

