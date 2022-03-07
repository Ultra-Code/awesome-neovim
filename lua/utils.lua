function _G.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

function _G.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
    return ...
end

-- escape termcode and keycode in lua for use in mapping expressions
function _G.t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.reload(module, parent_directory)
    local reload_module = require("plenary.reload").reload_module
    reload_module(module, parent_directory)
end
