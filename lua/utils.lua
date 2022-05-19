function _G.map(mode, lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, opts)
end

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
    return ...
end

function _G.reload()
    for name, _ in pairs(package.loaded) do
        if name:match("^lazy")
            or name:match("^mapping")
            or name:match("^plugrc")
            or name:match("^ui")
            or name:match("^editor")
            or name:match("^plugins")
            or name:match("^syntax")
            or name:match("^terminal")
            or name:match("^utils")
        then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("\nNvim configuration reloaded!", vim.log.levels.INFO)
end

function _G.reloadModule(module)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. module) then
            package.loaded[name] = nil
            require(name)
        end
    end

    vim.notify(
        "Nvim module " .. module .. " configuration reloaded!",
        vim.log.levels.INFO
    )
end
