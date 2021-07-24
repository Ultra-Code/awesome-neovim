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

linters.eslint = {
    lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %rror %m"},
    lintIgnoreExitCode = true
}

local formatters = {}

formatters.lua_format = {formatCommand = "lua-format -i", formatStdin = true}

formatters.prettier = {
    css = {
        formatCommand = "prettier --parser css --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    json = {
        formatCommand = "prettier --parser json --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    scss = {
        formatCommand = "prettier --parser scss --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    markdown = {
        formatCommand = "prettier --parser markdown --stdin-filepath ${INPUT}",
        formatStdin = true
    },
    yaml = {
        formatCommand = "prettier --parser yaml --stdin-filepath ${INPUT}",
        formatStdin = true
    }
}

settings.efm_settings = {
    init_options = {
        documentFormatting = true,
        codeAction = true,
        hover = true,
        documentSymbol = true,
        completion = true
    },
    filetypes = {
        "lua", "cpp", "c", "json", "css", "yaml", "markdown", "scss",
        "javascript", "typescript"
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {formatters.lua_format},
            cpp = {linters.cppcheck.cpp},
            c = {linters.cppcheck.c},
            css = {formatters.prettier.css},
            scss = {formatters.prettier.scss},
            json = {formatters.prettier.json, linters.eslint},
            yaml = {formatters.prettier.yaml},
            markdown = {formatters.prettier.markdown},
            javascript = {linters.eslint},
            typescript = {linters.eslint}
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
