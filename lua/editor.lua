local o = vim.o -- set editor global-local editor options
local wo = vim.wo -- set window-local editor options
local bo = vim.bo -- set buffer-local editor options
local g = vim.go -- set global editor editor options
local fn = vim.fn -- invoke vim-functions in lua
local autogroup = vim.api.nvim_create_augroup -- create autocmd group
local autocmd = vim.api.nvim_create_autocmd -- create autocmd

-- Remap leader key to ,
-- With a map leader it's possible to do extra key combinations
--  vim.g sets editor global variables
vim.g.mapleader = ","

-- Set clipboard to the +  registers only
-- if you want to use the * also add ,unnamed
if fn.has("clipboard") == 1 then
    vim.opt.clipboard:append("unnamedplus")
end

-- Restore cursor to file position in previous editing session
-- This autocommand jumps to the last known position in a file
-- just after opening it, if the '-- mark is set: >
local RetoreCursorPosition = autogroup("RetoreCursorPosition", { clear = true })
autocmd({ "BufReadPost" }, {
    group = RetoreCursorPosition,
    pattern = { "*" },
    command = [[call setpos(".", getpos("'\""))]],
})

-- Show line numbers
wo.number = true

-- Show the line number relative to the line with the cursor in front of each line.
wo.relativenumber = true

--Make a backup before overwriting a file.  The backup is removed after the file was successfully written
g.writebackup = true

-- tells neovim how backups are done
o.backupcopy = "auto"

-- The extension to be used for vim backup files
g.backupext = ".vimbak"

-- enable saving unsaved/unwritten files in a *.swp file
bo.swapfile = true

-- saves undo history to an undo file when writing a buffer to a file, and restores undo
-- history from the same file on buffer read.
bo.undofile = true

-- Maximum number of changes that can be undone.
o.undolevels = 30000

-- Don't redraw screen when executing macros,registers or untyped commands
g.lazyredraw = true

-- You will have bad experience for diagnostic messages when it's default 4000.
g.updatetime = 100

-- don't give |ins-completion-menu| messages.
g.shortmess = "c"

-- always merge sign column and number column into one
wo.signcolumn = "yes"

-- always expands tab to spaces. It is good when peers use different editor.
bo.expandtab = true

-- Don't let autocomplete affect usual typing habits
vim.opt_global.completeopt = { "menuone", "noselect" }

-- This option allows you to switch between multiple buffers
g.hidden = true -- without saving a changed buffer

-- Automatically enable mouse usage
g.mouse = "a"

-- Wrap-broken line prefix
o.showbreak = [[>>>\ \ \]]

-- enable line wrap
wo.wrap = true

-- Line wrap (number of cols)
bo.textwidth = 117

-- Highlight matching brace
g.showmatch = true

-- TODO: improve completions by using k{dict} and s{tsr} .:h 'complete'
-- text complete with CTRL-N or CTRL-P
bo.complete = "kspell"

-- Enable spell checking for español y ingles--
bo.spelllang = "en" --"en,es"

-- Show best nine spell checking candidates at most
vim.opt_global.spellsuggest = { "best", "9" }

-- When a word is CamelCased, assume "Cased" is a separate word: every upper-case character
-- in a word that comes after a lower case character indicates the start of a new word.
bo.spelloptions = "camel"

-- Use visual bell (no beeping)
g.visualbell = true

-- Always case-insensitive
g.ignorecase = true

-- Enable smart-case search
g.smartcase = true

-- case insensitive auto completion
g.wildignorecase = true

-- Number of auto-indent spaces
bo.shiftwidth = 4

-- Enable smart-indent
bo.smartindent = true

-- Number of spaces per Tab
bo.softtabstop = 4

-- Prompt confirmation dialogs
g.confirm = true

-- Command line height
g.cmdheight = 2

-- Auto-write all file changes
g.autowriteall = true

-- Display unprintable characters f12 - switches
o.list = true

-- Unprintable chars mapping
vim.opt.listchars = { tab = "••", trail = "•", extends = "»", precedes = "«" }

-- Enable folding
wo.foldmethod = "indent"

wo.foldlevel = 99

-- Remove Trailing whitespaces in all files
autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]] })

-- automatically show diagnostics on current line
autocmd({ "CursorHold" }, {
    pattern = { "*" },
    command = "lua vim.diagnostic.open_float(nil,{focus=false})",
})

--  format files on save
autocmd(
    { "BufWritePre" },
    { pattern = { "*" }, command = "lua vim.lsp.buf.formatting_seq_sync()" }
)
