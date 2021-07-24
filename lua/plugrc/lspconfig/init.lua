local on_attach = function(client, buffer)
    local signature_cfg = require('plugrc/lspconfig/signature')
    local saga_cfg = require('plugrc/lspconfig/saga')
    local builtin_lsp = require('plugrc/lspconfig/config')
    builtin_lsp.completion_kinds()
    builtin_lsp.sign_column_diagnostic_symbols()
    builtin_lsp.display_diagnostics_sources()

    require'lsp_signature'.on_attach(signature_cfg)
    require('lspsaga').init_lsp_saga(saga_cfg)

    local function set_keymap(...) vim.api.nvim_buf_set_keymap(buffer, ...) end

    local function set_option(...) vim.api.nvim_buf_set_option(buffer, ...) end

    set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

    if client.name == "efm" and vim.fn.getbufvar(buffer, '&filetype') == 'cpp' then
        client.resolved_capabilities.document_formatting = false
    end
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        set_keymap("v", "<leader>lf",
                   "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        -- lsp highlight element under cursor
        vim.cmd [[
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
    if client.resolved_capabilities.type_definition then
        set_keymap('n', '<leader>dt',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end

end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.signatureHelp.contextSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,

        rootdir = vim.loop.cwd
    }
end

local local_lsp_servers = {'clangd', 'hls', 'zls', 'efm'}

-- lsp-install
local function setup_servers()
    require'lspinstall'.setup()

    -- get all installed servers
    -- html ,css,lua,tailwindcss,vue,typescript
    local servers = require'lspinstall'.installed_servers()
    -- ... and add manually installed servers
    if servers then
        for _, local_server in pairs(local_lsp_servers) do
            table.insert(servers, local_server)
        end
    else
        servers = local_lsp_servers
    end

    local settings = require('plugrc.lspconfig.settings')
    local lua_settings = settings.lua_settings
    local efm_settings = settings.efm_settings
    local clangd_setting = settings.clangd_setting

    for _, server in pairs(servers) do
        local config = make_config()

        -- language specific config
        if server == "clangd" then
            config.cmd = clangd_setting.cmd
            config.filetypes = clangd_setting.filetypes
        end

        if server == "lua" then config.settings = lua_settings; end

        if server == "efm" then
            config.init_options = efm_settings.init_options;
            config.settings = efm_settings.settings;
            config.filetypes = efm_settings.filetypes
        end

        if server == "tailwindcss" then
            config.filetypes = {"html", "css", "vue", "scss"}
        end

        require'lspconfig'[server].setup(config);
    end

end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
