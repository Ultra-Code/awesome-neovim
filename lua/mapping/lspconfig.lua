-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function set_keymap(...)
    vim.api.nvim_set_keymap(...)
end
local function set_option(...)
    vim.api.nvim_set_option(...)
end

-- Enable completion triggered by <c-x><c-o>
set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings.
local opts = { noremap = true, silent = true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
set_keymap("n", "<space>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
set_keymap("n", "<space>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
set_keymap("n", "<space>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
set_keymap("n", "<space>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
set_keymap(
    "n",
    "<space>aw",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
)
set_keymap(
    "n",
    "<space>rw",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
)
set_keymap(
    "n",
    "<space>lw",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
)
set_keymap("n", "<space>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
set_keymap(
    "n",
    "<space>ld",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    opts
)
set_keymap(
    "n",
    "<space>sl",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    opts
)
set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
set_keymap("n", "<space>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil,{})]])
