return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        init = function()
            vim.cmd([[hi DashboardHeader guifg=#ee872d gui=bold]])
            vim.cmd([[hi DashboardProjectTitle guifg=#d55fde gui=bold]])
            vim.cmd([[hi DashboardProjectIcon guifg=#89ca78]])
            vim.cmd([[hi DashboardMruTitle guifg=#d55fde gui=bold]])
            vim.cmd([[hi DashboardShortCut guifg=#89ca78 gui=bold]])
        end,
        opts = {
            theme = "hyper",
            config = {
                header = {
                    [[]],
                    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
                    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
                    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
                    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
                    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
                    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                    [[]],
                },
                shortcut = {
                    {
                        icon = " ", --
                        desc = " Files",
                        group = "Label",
                        key = "f",
                        action = "Telescope find_files",
                    },
                    {
                        desc = "  Find text",
                        group = "@property",
                        key = "g",
                        action = "Telescope live_grep ",
                    },
                    {
                        desc = "  New file",
                        group = "Macro",
                        key = "n",
                        action = "NvimTreeToggle",
                    },
                    {
                        desc = "  Config",
                        group = "DiagnosticHint",
                        key = "c",
                        action = "e $MYVIMRC ",
                    },
                    {
                        desc = "  Quit",
                        group = "Number",
                        key = "q",
                        action = "qa",
                    },
                    -- {
                    --     desc = " Recent files",
                    --     group = "",
                    --     key = "r",
                    --     action = "Telescope oldfiles ",
                    -- },
                    -- {
                    --     desc = "󰊳 Update",
                    --     group = "@property",
                    --     key = "u",
                    --     action = "Lazy update",
                    -- },
                    -- {
                    --     icon="",
                    --     icon_hl = "@variable",
                    --     desc = "Apps",
                    --     group = "DiagnosticHint",
                    --     key = "a",
                    --     action = "Telescope app",
                    -- },
                    -- {
                    --     desc = " dotfiles",
                    --     group = "Number",
                    --     key = "d",
                    --     action = "Telescope dotfiles",
                    -- },
                },
            },
            hide = {
                statusline = true, -- hide statusline default is true
                tabline = false, -- hide the tabline
                winbar = true, -- hide winbar
            },
        },
    },
}
