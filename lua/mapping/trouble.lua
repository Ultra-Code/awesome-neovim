local opt = {silent = true, noremap = true}
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>TroubleToggle<cr>",opt)
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",opt)
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>TroubleToggle lsp_document_diagnostics<cr>",opt)
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",opt)
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",opt)
vim.api.nvim_set_keymap("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",opt)
