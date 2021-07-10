local o=vim.o
local wo=vim.wo
local bo=vim.bo
local g=vim.g
local cmd=vim.cmd
local fn=vim.fn
-- Remap leader key to ,
-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file

g.mapleader = ','

-- Use Unix as the standard file type
cmd[[set ffs=unix,dos,mac]]

cmd[[set encoding=UTF-8]]

-- == Python provider configurations == --
g.python3_host_prog='/usr/bin/python3'

--enable loading the plugin files for specific file types
cmd[[filetype plugin indent on]]

--Switch on syntax highlighting.
cmd[[syntax on]]

--set assembly language file to use nasm
g.asmsyntax = 'asm'

--Set clipboard to the +  registers only
--if you want to use the * also add ,unnamed
if fn.has('clipboard') == 1 then
     cmd[[set clipboard+=unnamedplus]]
end

--Restore cursor to file position in previous editing session
--This autocommand jumps to the last known position in a file
--just after opening it, if the '-- mark is set: >
cmd[[
augroup restore_cursor
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
]]

--Keep a backup copy of a file when overwriting it.This also sets the 'undofile' option, if
--available.  This will store the multi-level undo information in a file.  The result is
--that when you change a file, exit Vim, and then edit the file again, you can undo
--the changes made previously.
if fn.has('vms')==1 then
    cmd[[set nobackup]]
else
    cmd[[set backup]]
    if fn.has('persistent_undo')==1 then
        cmd[[set undofile]]
        cmd[[set undolevels=30000]]
        cmd[[set undoreload=30000]]
    end
end

--for vim's swap ; undo and backup organization
cmd[[set backupdir=/tmp//]]  --Location for backup of files before editing --
cmd[[set directory=/tmp//]]  --The location of swap files ,ie buffers that have not been save ie in memory
cmd[[set undodir=/tmp//]]    --Location for storing undo tree of the edited file--
cmd[[set backupext=.vimbak]] --The extension to be used for vim backup files

-- You will have bad experience for diagnostic messages when it's default 4000.
cmd[[set updatetime=100]]

-- don't give |ins-completion-menu| messages.
cmd[[set shortmess+=c]]

-- always merge signcolumn and number column into one
cmd[[set signcolumn=yes]]


--Do not keep a backup or .swp file. I don't like to have junk
--files, my source is anyway in cvs/svn/p4/git.
cmd[[set backup]]        -- create a backup of the file before editing
cmd[[set undofile]]      -- enable undofile , which helps you undo a lot and redo also a lot
cmd[[set noswapfile]]    -- enable saving unsaved/unwritten files in a *.swp file

cmd[[set nocompatible]]  -- Use Vim defaults (much better!), Vi is for 70's programmers!

cmd[[set expandtab]]     -- always expands tab to spaces. It is good when peers use different editor.

cmd[[set wildmenu]]      --Display completion matches in a status line.  That is when you type <Tab>
                   --and there is more than one match.

cmd[[set completeopt=menuone,noselect]] -- Don't let autocomplete affect usual typing habits

cmd[[set bs=2]]           -- allow backspacing over everything in insert mode

cmd[[set hidden]]         -- This option allows you to switch between multiple buffers
                    --without saving a changed buffer

cmd[[set mouse=a]]        --Automatically enable mouse usage

cmd[[set mousehide]]       -- Hide the mouse pointer while typing.

cmd[[set incsearch]]       -- highlight search string as search pattern is entered

cmd[[set hlsearch]]         --disables last search hilighting

cmd[[set number]]           -- Show line numbers

cmd[[set wrap]]             -- Automatically wrap text that extends beyond the screen length.

cmd[[set backspace=indent,eol,start]] -- Fixes common backspace problems

cmd[[set laststatus=2]]      -- Status bar

cmd[[set showbreak=>>>\ \ \]]    -- Wrap-broken line prefix

cmd[[set textwidth=79]]      -- Line wrap (number of cols)

cmd[[set showmatch]]         -- Highlight matching brace

cmd[[set complete+=kspell]]  --text complete with CTRL-N or CTRL-P

--set spell             -- Enable spell-checking

cmd[[set spelllang=es_mx,en_us]] -- Enable spell checking for espanol y ingles--

cmd[[set visualbell]]     --Use visual bell (no beeping)

cmd[[set ignorecase]]      --Always case-insensitie

cmd[[set smartcase]]     -- Enable smart-case search

cmd[[set autoindent]]      -- Auto-indent new lines

cmd[[set wildignorecase]]    --case insensitive auto completion

cmd[[set shiftwidth=4]]      -- Number of auto-indent spaces

cmd[[set smartindent]]      -- Enable smart-indent

cmd[[set smarttab]]      -- Enable smart-tabs

cmd[[set softtabstop=4]]     -- Number of spaces per Tab

cmd[[set confirm]]      -- Prompt confirmation dialogs

cmd[[set ruler]]             -- Show row and column ruler information

cmd[[set cmdheight=2]]       --Command line height

cmd[[set autowriteall]]      --Auto-write all file changes

cmd[[set history=10000]]       --Set the history size to maximum. by default it is 20

cmd[[set list]]          -- Display unprintable characters f12 - switches

cmd[[set listchars=tab:••\ ,trail:•,extends:»,precedes:« ]] -- Unprintable chars mapping


-- Enable folding
cmd[[set foldmethod=indent]]
cmd[[set foldlevel=99]]

--Enable Tags
cmd[[set tags=tags]]

--Remove Trailing whitespaces in all files
cmd[[autocmd BufWritePre * %s/\s\+$//e]]
