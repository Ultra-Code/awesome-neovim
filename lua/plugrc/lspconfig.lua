local signature_cfg = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 9,-- will show two lines of comment/doc
                 --(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode,
                 -- it does not affect signature help in normal
                 -- mode, 10 by default

  floating_window = true, -- show hint in a floating window,
                          --set to false for virtual text only mode

  fix_pos = true,  -- set to true, the floating window will
                    -- not auto-close until finish all parameters
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
    border = "shadow"   -- double, single, shadow, none
  },
  extra_trigger_chars = {} -- Array of extra characters that will
                           -- trigger signature completion, e.g., {"(", ","}
}

local on_attach = function(client,buffer)

    require'lsp_signature'.on_attach(signature_cfg)
    require('lspsaga').init_lsp_saga{}

     local function set_keymap(...)
        vim.api.nvim_buf_set_keymap(buffer, ...)
    end

      local function set_option(...)
        vim.api.nvim_buf_set_option(buffer, ...)
    end

       set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}

-- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        set_keymap("v", "<leader>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

     -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
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
    if client.resolved_capabilities.type_definition then
        set_keymap('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end

end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
      },
    },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local local_lsp_servers = {'clangd','hls','zls'}

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
    -- html ,css,lua,tailwindcss,vue,typescript
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  if servers then
        table.insert(servers,'clangd')
        table.insert(servers,'zls')
        table.insert(servers,'hls')
 else
         servers = local_lsp_servers
  end

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "clangd" then
      config.cmd = { "clangd","--query-driver=/usr/bin/g++","--clang-tidy","-j=5","--malloc-trim"};
      config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
    end

    if server == "lua" then
      config.settings = lua_settings;
    end

    require'lspconfig'[server].setup{config};
  end

end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
