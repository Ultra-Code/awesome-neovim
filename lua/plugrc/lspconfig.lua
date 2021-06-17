local lsp=require('lspconfig')

 signature_cfg = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 18,-- will show two lines of comment/doc
                 --(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode,
    -- it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window,
    --set to false for virtual text only mode
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 18, -- max height of signature floating_window,
    --if content is more than max_height, you can scroll down
                   -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window,
    --line will be wrapped if exceed max_width
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },
}

local on_attach = function(client,buffer)

    require'lsp_signature'.on_attach(signature_cfg)

     local function set_keymap(...)
        vim.api.nvim_buf_set_keymap(buffer, ...)
    end

    local opts = {noremap = true, silent = true}

-- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting == true then
        set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting == true then
        set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

     -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight ==true then
        -- lsp highlight element under cursor
        vim.cmd[[
        highlight link LspReferenceText WildMenu
        highlight LspReferenceRead gui=italic guifg=#232326 guibg=#c49060 "Uses IncSearch hi-grp
        highlight LspReferenceWrite gui=bold guifg=#232326 guibg=#e2c792 "Uses Search hi-grp
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
   end

    -- client.resolved_capabilities.type_definition =false
    if client.resolved_capabilities.type_definition == true then
        set_keymap('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
lsp.clangd.setup{
cmd =
{ "clangd", "--query-driver=/usr/bin/g++","--clang-tidy","-j=5","--malloc-trim" },
capabilities=capabilities,
on_attach= on_attach,
filetypes = { "c", "cpp"},
  --  on_init = function to handle changing offsetEncoding
root_dir = lsp.util.root_pattern("compile_commands.json", ".git"),
}

lsp.hls.setup{capabilities=capabilities, on_attach=on_attach}
require'lspconfig'.zls.setup
{
    cmd={"zls"},
    filetypes = {"zig","zir"},
    capabilities=capabilities,
    on_attach=on_attach,
    root_dir = lsp.util.root_pattern("zls.json", ".git")
}
require('lspsaga').init_lsp_saga()
