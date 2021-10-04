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
            },
        },
    },
}

local linters = {}

linters.cppcheck = {
    cpp = {
        lintCommand = "cppcheck --enable=warning,style,performance,portability,information,missingInclude --inconclusive -j 4 --template=gcc --language=c++ ${INPUT}",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
        lintIgnoreExitCode = true,
    },

    c = {
        lintCommand = "cppcheck --enable=warning,style,performance,portability,information,missingInclude --inconclusive -j 4 --template=gcc --language=c ${INPUT}",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
        lintIgnoreExitCode = true,
    },
}

linters.eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f(%l,%c): %rror %m" },
    lintIgnoreExitCode = true,
}

local formatters = {}

formatters.lua_format = { formatCommand = "lua-format -i", formatStdin = true }
formatters.stylua = { formatCommand = "stylua -", formatStdin = true }

formatters.prettier = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true,
}

settings.efm_settings = {
    init_options = {
        documentFormatting = true,
        codeAction = true,
        hover = true,
        documentSymbol = true,
        completion = true,
    },

    filetypes = {
        "lua",
        "cpp",
        "c",
        "css",
        "scss",
        "json",
        "yaml",
        "markdown",
        "javascript",
        "typescript",
    },

    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = { formatters.stylua },
            cpp = { linters.cppcheck.cpp },
            c = { linters.cppcheck.c },
            css = { formatters.prettier },
            scss = { formatters.prettier },
            json = { formatters.prettier },
            yaml = { formatters.prettier },
            markdown = { formatters.prettier },
            javascript = { linters.eslint },
            typescript = { linters.eslint },
        },
    },
}

settings.clangd_setting = {
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/g++",
        "--clang-tidy",
        "-j=5",
        "--malloc-trim",
    },
    filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
}

settings.ccls_settings = {
    {
        filetypes = { "c", "cpp" },
        init_options = {
            index = {
                threads = 0,
            },
            cache = {
                directory = ".ccls-cache",
            },
            clang = {
                excludeArgs = { "-frounding-math" },
                extraArgs = {},
            },
        },
    },
}

return settings
