return {
    {
        "nvim-neorg/neorg",
        -- lazy-load on filetype
        ft = "norg",
        build = function()
            vim.cmd("Neorg sync-parsers")
        end,
        opts = {
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
        },
    },
}
