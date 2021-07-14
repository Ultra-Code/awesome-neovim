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
}

local linters = {}

linters.cppcheck = {
    cpp = {
        lintCommand = 'cppcheck --enable=warning,style,performance,portability,information,missingInclude --inconclusive -j 4 --template=gcc --language=c++ ${INPUT}',
        lintStdin = true,
        lintFormats = {'%f:%l:%c: %m'},
        lintIgnoreExitCode = true
    },
    c = {
        lintCommand = 'cppcheck --enable=warning,style,performance,portability,information,missingInclude --inconclusive -j 4 --template=gcc --language=c ${INPUT}',
        lintStdin = true,
        lintFormats = {'%f:%l:%c: %m'},
        lintIgnoreExitCode = true
    }
}

local formatters = {}

formatters.lua_format = {formatCommand = "lua-format -i", formatStdin = true}

settings.efm_settings = {
    log_level = 0,
    log_file = '/tmp/efm.log',
    init_options = {
        documentFormatting = true,
        codeAction = true,
        hover = true,
        documentSymbol = true,
        completion = false
    },
    filetypes = {"lua", "cpp", "c"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {formatters.lua_format},
            cpp = {linters.cppcheck.cpp},
            c = {linters.cppcheck.c}
        }
    }
}

settings.clangd_setting = {
    cmd = {
        "clangd", "--query-driver=/usr/bin/g++", "--clang-tidy", "-j=5",
        "--malloc-trim"
    },
    filetypes = {"c", "cpp"} -- we don't want objective-c and objective-cpp!
}

return settings
