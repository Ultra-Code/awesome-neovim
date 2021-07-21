require('utils')
local opt = {silent = true}
map("n", "<leader>tt", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle<cr>",opt)
map("n", "<leader>tw", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",opt)
map("n", "<leader>td", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle lsp_document_diagnostics<cr>",opt)
map("n", "<leader>tl", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle loclist<cr>",opt)
map("n", "<leader>tq", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle quickfix<cr>",opt)
map("n", "<leader>tr", "<cmd>packadd trouble.nvim<cr>|<cmd>TroubleToggle lsp_references<cr>",opt)
