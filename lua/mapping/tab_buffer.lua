require("utils")
-- === Moving around, tabs, windows and buffers === --

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode
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

local opt = { remap = true }
local mode = { "n", "v", "o" }
map(mode, "<leader>bd", "<cmd>bdelete<cr>", opt) -- Close the current buffer
map(mode, "<leader>ba", "<cmd>bufdo bd<cr>", opt) -- Close all the buffers
map(mode, "]b", "<cmd>bnext<cr>", opt) -- move forward to the next buffer in the buffer list
map(mode, "[b", "<cmd>bprevious<cr>", opt) -- move back to the previous buffer in the buffer list
map(mode, "<leader>bp", "<cmd>b#<cr>", opt) -- move to the last visited buffer
map(mode, "<leader>b1", "<cmd>bfirst<cr>", opt) -- move to the first buffer in the buffer list
map(mode, "<leader>b9", "<cmd>blast<cr>", opt) -- move to the last buffer in the buffer list

-- pick a buffer to view from the buffer list
map("n", "<leader>bs", "<cmd>BufferLinePick<CR>", { silent = true, })
-- pick a buffer to closes from the buffer list
map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { silent = true, })

-- Useful mappings for managing tabs
map(mode, "<leader>tw", "<cmd>tabnew<cr>", opt)
map(mode, "<leader>to", "<cmd>tabonly<cr>", opt)
map(mode, "<leader>tc", "<cmd>tabclose<cr>", opt)
map(mode, "<leader>tm", "<cmd>tabmove<cr>", opt)
map(mode, "<leader>tn", "<cmd>tabnext<cr>", opt)
map(mode, "<leader>tp", "<cmd>tabprevious<cr>", opt)
map(mode, "<leader>tf", "<cmd>tabfirst<cr>", opt)
