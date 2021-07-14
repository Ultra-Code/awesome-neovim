local settings = {}

-- Configure lua language server for neovim development
settings.lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = vim.split(package.path, ';')
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'}
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true)
        }
    }
};

settings.efm_settings = {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {{formatCommand = "lua-format -i", formatStdin = true}}
        }
    }
};

settings.clangd_setting = {
    cmd = {
        "clangd", "--query-driver=/usr/bin/g++", "--clang-tidy", "-j=5",
        "--malloc-trim"
    },
    filetypes = {"c", "cpp"} -- we don't want objective-c and objective-cpp!
};

return settings
