local utils = require("config.utils")
local map = vim.keymap.set

-- reload/source current file
map("n", "<localleader>.", function()
    vim.cmd([[luafile %]])
    vim.notify("reloaded " .. vim.fn.expand("%"))
end, { buffer = true, desc = "reload current lua file" })

-- reload a particular module
map("n", "<localleader>rm", function()
    vim.ui.input({
        prompt = "Enter the name of the module you want to reload:",
        default = nil,
        completion = "file",
    }, function(module_name)
        if module_name == "" then
            return
        else
            utils.reload_one(module_name)
            vim.notify(
                "!Reloaded Nvim Module " .. module_name .. ".lua!",
                vim.log.levels.INFO
            )
        end
    end)
end, { buffer = true, desc = "reload a particular lua module" })

-- reload all nvim configuration modules
-- map("n", "<localleader>ra", function()
--     utils.reload_all()
--     vim.notify("!Reloaded All Nvim Modules!", vim.log.levels.INFO)
-- end, { buffer = true, desc = "reload all modules" })
