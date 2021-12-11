local o = vim.opt -- editor options
local g = vim.g -- Global editor variables
local cmd = vim.cmd -- exectue vimscript in lua
local fn = vim.fn -- invoke vim-functions in lua
-- Remap leader key to ,
-- With a map leader it's possible to do extra key combinations
-- like <leader>w saves the current file

g.mapleader = ","

-- == Python provider configurations == --
g.python3_host_prog = "/usr/bin/python3"

-- enable loading the plugin files for specific file types
cmd([[filetype plugin indent on]])

-- Switch on syntax highlighting.
o.syntax = "on"

-- set assembly language file to use nasm
g.asmsyntax = "asm"

-- Set clipboard to the +  registers only
-- if you want to use the * also add ,unnamed
if fn.has("clipboard") == 1 then
    vim.opt.clipboard:append("unnamedplus")
end

-- Restore cursor to file position in previous editing session
-- This autocommand jumps to the last known position in a file
-- just after opening it, if the '-- mark is set: >
cmd([[
augroup restore_cursor
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
]])

-- Keep a backup copy of a file when overwriting it.This also sets the 'undofile' option, if
-- available.  This will store the multi-level undo information in a file.  The result is
-- that when you change a file, exit Vim, and then edit the file again, you can undo
-- the changes made previously.
if fn.has("vms") == 1 then
    o.backup = false
else
    -- create a backup of the file before editing
    o.backup = true
    if fn.has("persistent_undo") == 1 then
        -- enable undofile , which helps you undo a lot and redo also a lot
        o.undofile = true
        o.undolevels = 30000
        o.undoreload = 30000
    end
end

-- Don't redraw screen when executing macros,registers or untyped commands
o.lazyredraw = true

-- enable tree style view
g.netrw_liststyle = 3

-- Disable top banner can be switched with I
g.netrw_banner = 0

-- Incremental live completion
o.inccommand = "nosplit"

-- for vim's swap ; undo and backup organization
-- Location for backup of files before editing --
o.backupdir = "/tmp/"

-- The location of swap files ,ie buffers that have not been save ie in memory
o.directory = "/tmp/"

-- Location for storing undo tree of the edited file--
o.undodir = "/tmp/"

-- The extension to be used for vim backup files
o.backupext = ".vimbak"

-- You will have bad experience for diagnostic messages when it's default 4000.
o.updatetime = 100

-- don't give |ins-completion-menu| messages.
o.shortmess = "c"

-- always merge signcolumn and number column into one
o.signcolumn = "yes"

-- enable saving unsaved/unwritten files in a *.swp file
o.swapfile = false

-- always expands tab to spaces. It is good when peers use different editor.
o.expandtab = true

-- Don't let autocomplete affect usual typing habits
o.completeopt = "menuone,noselect"

-- This option allows you to switch between multiple buffers
o.hidden = true -- without saving a changed buffer

-- Automatically enable mouse usage
o.mouse = "a"

-- Show line numbers
o.number = true

-- Wrap-broken line prefix
o.showbreak = [[>>>\ \ \]]

-- enable line wrap
o.wrap = true

-- Line wrap (number of cols)
o.textwidth = 117

-- Highlight matching brace
o.showmatch = true

-- text complete with CTRL-N or CTRL-P
o.complete = "kspell"

-- Enable spell checking for espanol y ingles--
o.spelllang = "es_us,en_us"

-- Use visual bell (no beeping)
o.visualbell = true

-- Always case-insensitie
o.ignorecase = true

-- Enable smart-case search
o.smartcase = true

-- case insensitive auto completion
o.wildignorecase = true

-- Number of auto-indent spaces
o.shiftwidth = 4

-- Enable smart-indent
o.smartindent = true

-- Number of spaces per Tab
o.softtabstop = 4

-- Prompt confirmation dialogs
o.confirm = true

-- Show row and column ruler information
o.ruler = true

-- Command line height
o.cmdheight = 2

-- Auto-write all file changes
o.autowriteall = true

-- Set the history size to maximum. by default it is 20
o.history = 10000

-- Display unprintable characters f12 - switches
o.list = true

-- Unprintable chars mapping
o.listchars = { tab = "••", trail = "•", extends = "»", precedes = "«" }

-- Enable folding
o.foldmethod = "indent"

o.foldlevel = 99

-- Remove Trailing whitespaces in all files
cmd([[autocmd BufWritePre * %s/\s\+$//e]])
