local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    mode = mode == nil and { "n" } or type(mode) == "string" and { mode } or mode
    vim.keymap.set(mode, lhs, rhs, opts)
end

local opt = { remap = true }
local utils = require("config.utils")

vim.cmd [[ cabbrev ht tab help]] --map("c","h","tab help")

-- search selected region on current line
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opt)

-- Map jk to ESC
map({ "i", "v" }, "jk", "<ESC>", { remap = false, nowait = true })

map("n", "B", "m`0i<CR><ESC>``i", opt) -- J(join) B(BackJoin): move text after cursor to next line

-- keep pasting over the same thing, ie. delete content and paste something in it place
map("n", "<leader>p", [[m`0"_DP``]], opt)
map("v", "<leader>p", [[m`"_dP``]], opt)

-- delete content without clobbering registers
map("n", "<leader>d", [["_dd]], opt)
map("v", "<leader>d", [["_d]], opt)

-- Switch CWD to the directory of the open buffer
map({ "n", "v", "o" }, "<leader>cd", "<cmd>cd %:p:h<cr>:pwd<cr>", opt)

-- === Moving around, tabs, windows and buffers === --
-- To use `ALT+{h,j,k,l}` to navigate windows from any mode
map({ "t", "i" }, "<C-h>", [[<C-\><C-N><C-w>h]])
map({ "t", "i" }, "<C-j>", [[<C-\><C-N><C-w>j]])
map({ "t", "i" }, "<C-k>", [[<C-\><C-N><C-w>k]])
map({ "t", "i" }, "<C-l>", [[<C-\><C-N><C-w>l]])
-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

local mode = { "n", "v", "o" }

-- buffers
if utils.has("bufferline.nvim") then
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
    map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
    map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" }) -- move back to the previous buffer in the buffer list
    map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })     -- move forward to the next buffer in the buffer list
end
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>b#<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>b1", "<cmd>bfirst<cr>", opt)                          -- move to the first buffer in the buffer list
map("n", "<leader>b9", "<cmd>blast<cr>", opt)                           -- move to the last buffer in the buffer list
map("n", "<leader>bd", "<cmd>bdelete<cr>", opt)                         -- Close the current buffer
map("n", "<leader>bo", "<cmd>%bdelete<bar>edit#<bar>bdelete#<cr>", opt) -- Close all buffers except current
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New File" })          -- new file

-- Useful mappings for managing tabs
map(mode, "<leader>t1", "<cmd>tabfirst<cr>", opt)
map(mode, "<leader>t9", "<cmd>tablast<cr>", opt)
map(mode, "<leader>td", "<cmd>tabclose<cr>", opt)
map(mode, "<leader>tn", "<cmd>tabnew<cr>", opt)
map(mode, "<leader>to", "<cmd>tabonly<cr>", opt)
--TODO: tabmove should take an input
map(mode, "<leader>tm", "<cmd>tabmove<cr>", opt)
map(mode, "<leader>]t", "<cmd>tabnext<cr>", opt)
map(mode, "<leader>[t", "<cmd>tabprevious<cr>", opt)

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>=", "<C-W>=", { desc = "resize and make windows equal" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", function()
    vim.cmd [[w]]
end, { desc = "Save file" })

-- quit
map("n", "<C-q>", function()
    vim.cmd [[qall]]
end, { desc = "Quit all" })

-- === Terminal === "
-- Mapping to open terminal emulator in nvim
-- open terminal on alt+t
map("n", "<M-t>", function()
    vim.cmd([[
        split term://zsh
        resize 15
    ]])
end)
-- mapping to close terminal emulator
map("t", "<M-t>", [[<C-\><C-n>:bd!<CR>]])


-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- toggle options
-- === Spell checking === "
--vim.cmd [[set spell!]] also works
map("n", "<leader>us", function() utils.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() utils.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
    utils.toggle("relativenumber", true)
    utils.toggle("number")
end, { desc = "Toggle Line Numbers" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() utils.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })

if not utils.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end
