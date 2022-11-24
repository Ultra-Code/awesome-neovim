local settings = {}

-- Configure lua language server for neovim development
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

settings.lua_settings = {
    cmd = {
        "lua-language-server",
        "-E",
        "/usr/share/lua-language-server/main.lua",
    },
    settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of Neovim
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- This feature causes the lsp to use the "environment emulation" feature to suggest
                -- applying a library/framework when a certain keyword or filename has been found
                checkThirdParty = false,
            },
        },
    },
}

settings.clangd_setting = {
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/clang++",
        "--clang-tidy",
        "-j=5",
        "--malloc-trim",
        "--offset-encoding=utf-16"
    },
    filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
}

return settings
