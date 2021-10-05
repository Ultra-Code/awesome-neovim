require("neorg").setup({
    load = {
        ["core.defaults"] = {}, -- Tells neorg to load the module called core.defaults with no extra data
        ["core.norg.concealer"] = {}, -- Since this module isn't part of core.defaults, we can include it ourselves, like so
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
            },
        },
        ["core.norg.dirman"] = {
            config = { -- Load a custom configuration
                -- Define your workspaces here!
                workspaces = {
                    -- You can give it any name and any directory, get creative!
                    notes = "~/neorg",
                },
                -- Automatically detect whenever we have entered a subdirectory of a workspace
                autodetect = true,
                -- Automatically change the directory to the root of the workspace every time
                autochdir = true,
            },
        },
    },
    hook = function()
        -- The code that we will showcase below goes here
        -- This sets the leader for all Neorg keybinds. It is separate from the regular <Leader>,
        -- And allows you to shove every Neorg keybind under one "umbrella".
        local neorg_leader = "<Leader>o" -- You may also want to set this to <Leader>o for "organization"

        -- Require the user callbacks module, which allows us to tap into the core of Neorg
        local neorg_callbacks = require("neorg.callbacks")

        -- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
        -- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
        -- needs to reevaluate all the bound keys is invoked
        neorg_callbacks.on_event(
            "core.keybinds.events.enable_keybinds",
            function(_, keybinds)
                -- Map all the below keybinds only when the "norg" mode is active
                keybinds.map_event_to_mode("norg", {
                    n = { -- Bind keys in normal mode
                        -- Keys for managing TODO items and setting their states
                        { "gtd", "core.norg.qol.todo_items.todo.task_done" },
                        { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
                        { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
                        {
                            "<C-Space>",
                            "core.norg.qol.todo_items.todo.task_cycle",
                        },
                    },
                }, {
                    silent = true,
                    noremap = true,
                })
            end
        )
    end,
    logger = {
        -- Should print the output to neovim while running
        use_console = true,
        -- Should highlighting be used in console (using echohl)
        highlights = true,
        -- Should write to a file
        use_file = true,
        -- Any messages above this level will be logged.
        level = "warn",
        -- Level configuration
        modes = {
            { name = "trace", hl = "Comment" },
            { name = "debug", hl = "Comment" },
            { name = "info", hl = "None" },
            { name = "warn", hl = "WarningMsg" },
            { name = "error", hl = "ErrorMsg" },
            { name = "fatal", hl = "ErrorMsg" },
        },
        -- Can limit the number of decimals displayed for floats
        float_precision = 0.01,
    },
    icons = {
        todo = {
            enabled = true, -- Conceal TODO items

            done = {
                enabled = true, -- Conceal whenever an item is marked as done
                icon = "",
            },
            pending = {
                enabled = true, -- Conceal whenever an item is marked as pending
                icon = "",
            },
            undone = {
                enabled = true, -- Conceal whenever an item is marked as undone
                icon = "×",
            },
        },
        quote = {
            enabled = true, -- Conceal quotes
            icon = "∣",
        },
        heading = {
            enabled = true, -- Enable beautified headings

            -- Define icons for all the different heading levels
            level_1 = {
                enabled = true,
                icon = "◉",
            },

            level_2 = {
                enabled = true,
                icon = "○",
            },
        },
    },
})
