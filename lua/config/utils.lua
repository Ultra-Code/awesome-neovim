local M = {}

function _G.dump(...)
    vim.print(...);
end

function M.reload_all()
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

function M.reload_one(module)
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

---@param editor_variable? boolean?
---@param values? {[1]:any, [2]:any}
---@param option string
function M.toggle(option, editor_variable, values)
    if values then
        if not editor_variable then
            if vim.opt_local[option]:get() == values[1] then
                vim.opt_local[option] = values[2]
            else
                vim.opt_local[option] = values[1]
            end
            vim.notify("Set option " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO)
        else
            local bufnr = vim.api.nvim_get_current_buf()
            if vim.b[bufnr][option] == values[1] then
                vim.b[bufnr][option] = values[2]
            else
                --if option is unset or nil
                vim.b[bufnr][option] = values[1]
            end
            --:h debug.getinfo() or lua_getinfo() to get information about a function
            vim.notify(
                "Set variable " .. option .. " to " .. tostring(vim.b[bufnr][option]), vim.log.levels.INFO)
        end
    else
        if not editor_variable then
            vim.opt_local[option] = not vim.opt_local[option]:get()
            vim.notify("Set option " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO)
        else
            local bufnr = vim.api.nvim_get_current_buf()
            vim.b[bufnr][option] = not vim.b[bufnr][option] and true or false
            vim.notify("Set variable " .. option .. " to " .. tostring(vim.b[bufnr][option]),
                vim.log.levels.INFO)
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
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, bufnr)
        end,
    })
end

return M;
