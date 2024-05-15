local opt = vim.opt
local opt_global = vim.opt_global
local fn = vim.fn -- invoke vim-functions in lua

vim.g.editorconfig = false
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

-- Set clipboard to the +  registers only
-- if you want to use the * also add ,unnamed
-- Also enable clipboard for WSL
if fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "/mnt/c/WINDOWS/system32/clip.exe",
            ["*"] = "/mnt/c/WINDOWS/system32/clip.exe",
        },
        paste = {
            ["+"] = '/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = '/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
    opt.clipboard:append({ "unnamedplus" })
else
    opt.clipboard:append({ "unnamedplus" })
end

opt.termguicolors = true

-- Show line numbers
opt.number = true

-- open new split panes to right and below
opt.splitright = true
opt.splitbelow = true

-- Show the line number relative to the line with the cursor in front of each line.
opt.relativenumber = true

--Make a backup before overwriting a file.  The backup is removed after the file was successfully written
-- unless the 'backup' option is also on.
opt.writebackup = true

--Make a backup before overwriting a file.  Leave it around after the file has been successfully written.
--this make sure you alway have a backup of a file around,meaning in cases where there is no swapfile
--to recover from you can use the backup file directly
opt.backup = true

--List of directories for the backup file
opt_global.backupdir = { "/tmp//" }

-- tells neovim how backups are done
opt.backupcopy = "auto"

-- The extension to be used for vim backup files
opt.backupext = ".vimbak"

-- enable saving unsaved/unwritten files in a *.swp file
opt.swapfile = true

-- saves undo history to an undo file when writing a buffer to a file, and restores undo
-- history from the same file on buffer read.
opt.undofile = true

-- Maximum number of changes that can be undone.
opt.undolevels = 30000

-- You will have bad experience for diagnostic messages when it's default 4000.
opt.updatetime = 100

-- Time in milliseconds to wait for a mapped sequence to complete.
opt.timeoutlen = 500

-- don't give |ins-completion-menu| messages.
opt.shortmess:append({ c = true, W = true, I = true })

-- always merge sign column and number column into one
opt.signcolumn = "yes"

-- Don't let autocomplete affect usual typing habits
opt_global.completeopt = { "menu", "menuone", "noselect" }

opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.concealcursor = "nc" --Sets the modes in which text in the cursor line can also be concealed.

opt.cursorline = true -- Enable highlighting of the current line

opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- This option allows you to switch between multiple buffers
-- without saving a changed buffer
opt.hidden = false

-- Automatically enable mouse usage
opt.mouse = "a"

-- enable mouse move event
opt.mousemoveevent = false

-- enable line wrap
opt.wrap = true

-- Wrap-broken line prefix
opt.showbreak = [[↪ ]]

-- wrap long lines at a character in `breakat`
opt.linebreak = true

--wrapped line will continue visually indented
opt.breakindent = true

-- Maximum width (number of cols) of text that is being inserted
opt.textwidth = 80

-- set to +1 to highlight column after textwidth
-- opt.colorcolumn = "+1"

-- Highlight matching brace
opt.showmatch = true

-- TODO: improve completions by using k{dict} and s{tsr} .:h 'complete'
-- text complete with CTRL-N or CTRL-P
opt.complete = "kspell"

-- Enable spell checking for español y ingles--
opt.spelllang = { "en" } --"en,es"

-- Show best nine spell checking candidates at most
opt_global.spellsuggest = { "best", "9" }

-- When a word is CamelCased, assume "Cased" is a separate word: every upper-case character
-- in a word that comes after a lower case character indicates the start of a new word.
opt.spelloptions = "camel"

-- make diff mode always open in vertical split
opt_global.diffopt:append({ "vertical" })

-- Use visual bell (no beeping)
opt.visualbell = true

-- Always case-insensitive
opt.ignorecase = true

-- Enable smart-case search
opt.smartcase = true

-- case insensitive auto completion
opt.wildignorecase = true

--Set 'tabstop' and 'shiftwidth' to whatever you prefer and use 'expandtab'.
--This way you will always insert spaces.  The formatting will never be messed up when 'tabstop' is changed.
--Number of spaces that a <Tab> in the file counts for
opt.tabstop = 4

-- Number of auto-indent spaces
opt.shiftwidth = 4

-- Number of spaces per Tab
-- When 'softtabstop' is negative, the value of 'shiftwidth' is used.
opt.softtabstop = -1

-- always expands tab to spaces. It is good when peers use different editor.
opt.expandtab = true

-- Prompt confirmation dialogs
opt.confirm = true

-- Command line height
opt.cmdheight = 0

-- Auto-write all file changes
opt.autowriteall = true

--When this option is set, the screen will not be redrawn while executing
--macros, registers and other commands that have not been typed
opt.lazyredraw = false

-- Display unprintable characters f12 - switches
opt.list = true

-- Unprintable chars mapping
-- {tab = "••"|">~",eol = "↴"|"¶"|"$", nbsp = "␣"|"%", space = "_" }
opt.listchars =
    { tab = [[→→]], trail = "•", extends = "»", precedes = "«" }

-- Enable folding
opt.foldmethod = "expr"

opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- diable folding at startup
opt.foldenable = false

-- set the number of screen lines above which a fold is displayed closed
opt.foldminlines = 5
