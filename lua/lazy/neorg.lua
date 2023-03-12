local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local neorg_group = augroup("neorg", { clear = false });

autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.norg" },
    group = neorg_group,
    desc = "autocmd to load neorg only in norg files",
    callback = function(args)
        _ = args
        if not package.loaded["plenary"] then
            vim.cmd([[ packadd plenary.nvim ]])
        end
        if not package.loaded["neorg"] then
            vim.cmd([[ packadd neorg ]])
        end

        require("neorg").setup({
            load = {
                ["core.defaults"] = {},             -- Tells neorg to load the module called core.defaults with no extra data
                ["core.keybinds"] = {               -- Configure core.keybinds
                    config = {
                        default_keybinds = true,    -- Generate the default keybinds
                        neorg_leader = "<Leader>o", -- This is the default if unspecified
                    },
                },
                ["core.norg.concealer"] = {},
                ["core.norg.dirman"] = {
                    config = {
                        -- Define your workspaces here!
                        workspaces = {
                            -- You can give it any name and any directory, get creative!
                            notes = "~/.local/neorg",
                        },
                    },
                },
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
            },
        })
    end
})
