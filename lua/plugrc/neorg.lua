require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- Tells neorg to load the module called core.defaults with no extra data
        ["core.keybinds"] = { -- Configure core.keybinds
            config = {
                default_keybinds = true, -- Generate the default keybinds
                neorg_leader = "<Leader>o", -- This is the default if unspecified
            },
        },
        ["core.norg.concealer"] = {}, -- Since this module isn't part of core.defaults, we can include it ourselves, like so
        ["core.norg.dirman"] = {
            config = { -- Load a custom configuration
                -- Define your workspaces here!
                workspaces = {
                    -- You can give it any name and any directory, get creative!
                    notes = "~/.local/neorg",
                },
            },
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
            },
        },
    },
})
