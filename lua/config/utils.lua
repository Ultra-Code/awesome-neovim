local M = {}

function _G.dump(...)
    vim.pretty_print(...);
end

function _G.reloadAllModules()
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
end

function _G.reload(module)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. module) then
            package.loaded[name] = nil
            require(name)
            return
        end
    end
end

--{ "git", "rg", { "fd", "fdfind" }, "lazygit" }
M.check_if_cmd_exist = function(cmds)
    local result = {}
    for _, cmd in ipairs(cmds) do
        local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
        local commands = type(cmd) == "string" and { cmd } or cmd
        ---@cast commands string[]
        local found = false
        for _, c in ipairs(commands) do
            if vim.fn.executable(c) == 1 then
                name = c
                found = true
            end
            result[name] = { found }
        end
    end
    return result
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        vim.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO)
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            vim.notify("Enabled " .. option, vim.log.levels.INFO)
        else
            vim.notify("Disabled " .. option, vim.log.levels.INFO)
        end
    end
end

---@param fn fun()
function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("Lazy", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

---@param modules string[]
--modules like "autocmds" | "options" | "keymaps"
M.lazy_load = function(modules)
    -- when no file is opened at startup
    if vim.fn.argc(-1) == 0 then
        -- autocmds and keymaps can wait to load
        -- always load lazyvim, then user file
        M.on_very_lazy(function()
            for i = 1, #modules do
                require(modules[i])
            end
        end)
    else
        -- load them now so they affect the opened buffers
        for i = 1, #modules do
            require(modules[i])
        end
    end
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

return M;
