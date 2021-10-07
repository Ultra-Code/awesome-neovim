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

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

settings.cppcheck = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "cpp", "c" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = "cppcheck",
        args = {
            "--enable=warning,style,performance,portability,information,missingInclude",
            "--inconclusive",
            "-j 4",
            "--template=gcc",
            "$FILENAME",
        },
        to_stdin = true,
        from_stderr = true,
        -- choose an output format (raw, json, or line)
        format = "line",
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function
        on_output = helpers.diagnostics.from_pattern(
            [[(%d+):(%d+): (%w+): (.*)]], -- (%[(%w+)%])?
            { "row", "col", "severity", "message" }, -- "code"
            {
                severities = {
                    note = helpers.diagnostics.severities["information"],
                },
            }
        ),
    }),
}
--info = h.diagnostics.severities["information"],
null_ls.register({ name = "cppcheck", sources = { settings.cppcheck } })

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

return settings
