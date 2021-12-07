require("utils")
-- === Moving around, tabs, windows and buffers === --

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
map("t", "<A-h>", [[<C-\><C-N><C-w>h]])
map("t", "<A-j>", [[<C-\><C-N><C-w>j]])
map("t", "<A-k>", [[<C-\><C-N><C-w>k]])
map("t", "<A-l>", [[<C-\><C-N><C-w>l]])
map("i", "<A-h>", [[<C-\><C-N><C-w>h]])
map("i", "<A-j>", [[<C-\><C-N><C-w>j]])
map("i", "<A-k>", [[<C-\><C-N><C-w>k]])
map("i", "<A-l>", [[<C-\><C-N><C-w>l]])
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

local opt = { noremap = false }
map("", "<leader>bd", ":bdelete<cr>", opt) -- Close the current buffer
map("", "<leader>bda", ":bufdo bd<cr>", opt) -- Close all the buffers
map("", "<leader>bf", ":bnext<cr>", opt) -- move forward to the next buffer in the buffer list
map("", "<leader>bb", ":bprevious<cr>", opt) -- move back to the previous buffer in the buffer list
map("", "<leader>bp", ":b#<cr>", opt) -- move to the last visited buffer
map("", "<leader>b1", ":bfirst<cr>", opt) -- move to the first buffer in the buffer list
map("", "<leader>b9", ":blast<cr>", opt) -- move to the last buffer in the buffer list
map("n", "<leader>bs", ":BufferLinePick<CR>", { -- pick a buffer from the buffer list
    noremap = true,
    silent = true,
})

-- Useful mappings for managing tabs
map("", "<leader>tnw", ":tabnew<cr>", opt)
map("", "<leader>to", ":tabonly<cr>", opt)
map("", "<leader>tc", ":tabclose<cr>", opt)
map("", "<leader>tm", ":tabmove", opt)
map("", "<leader>tn", ":tabnext<cr>", opt)
map("", "<leader>tp", ":tabprevious<cr>", opt)
map("", "<leader>tf", ":tabfirst<cr>", opt)
-- pass a positive or negative argument to the command to move by that step--
map("", "<leader>t", ":tabnext", opt)

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("", "<leader>te", ':tabedit <c-r>=expand("%:p:h")<cr><cr>', opt)

-- Switch CWD to the directory of the open buffer
map("", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>", opt)
