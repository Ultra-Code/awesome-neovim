require("utils")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- Mappings.
local opts = { silent = true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
map("n", "<space>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "<space>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "<space>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- set_keymap("n", "<space>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<space>gr", "<cmd>Trouble lsp_references<cr>", opts)
map("n", "<space>lw", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<space>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "<space>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<space>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
