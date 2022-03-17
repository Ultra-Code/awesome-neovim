require("utils")
local opt = { silent = true }

map("n", "<leader>tt", "<cmd>Trouble<cr>", opt)
map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", opt)
map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", opt)
map("n", "<leader>tl", "<cmd>Trouble loclist<cr>", opt)
map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", opt)
