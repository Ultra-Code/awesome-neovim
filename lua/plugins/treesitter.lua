-- === Syntax Plugins ===
return {
    -- Nvim Treesitter configurations and abstraction layer
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        build = function()
            vim.cmd("TSUpdate")
        end,
        opts = {
            -- A list of parser names, or "all" (the 1st five listed parsers should always be installed)
            -- For web dev "jsonc", "typescript", "css", "html", "vue",
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "cpp",
                "zig",
                "norg",
                "bash",
                "glsl",
                "markdown",
                "markdown_inline",
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            ignore_install = {}, -- List of parsers to ignore installing
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {}, -- list of language that will be disabled
            },
            --Incremental selection based on the named nodes from the grammar.
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            --Indentation based on treesitter for the = operator.
            indent = {
                enable = true,
            },
            autopairs = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        keys = {
            { "<LocalLeader>tsto", desc = "Enable Treesitter textobjects" },
        },
        opts = {
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = {
                            query = "@function.outer",
                            desc = "select a function",
                        },
                        ["if"] = {
                            query = "@function.inner",
                            desc = "select inner function",
                        },
                        ["ac"] = {
                            query = "@class.outer",
                            desc = "select a class",
                        },
                        ["ic"] = {
                            query = "@class.inner",
                            desc = "Select inner part of a class region",
                        },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = {
                            query = "@scope",
                            query_group = "locals",
                            desc = "Select language scope",
                        },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = {
                            query = "@class.outer",
                            desc = "Next class start",
                        },
                        --
                        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                        ["]o"] = "@loop.*",
                        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        --
                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        --Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        ["]s"] = {
                            query = "@scope",
                            query_group = "locals",
                            desc = "Next scope",
                        },
                        ["]z"] = {
                            query = "@fold",
                            query_group = "folds",
                            desc = "Next fold",
                        },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]O"] = "@loop.*",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[o"] = "@loop.*",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[O"] = "@loop.*",
                        ["[]"] = "@class.outer",
                    },
                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    goto_next = {
                        ["]f"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[f"] = "@conditional.outer",
                    },
                },
                lsp_interop = {
                    enable = true,
                    border = "none",
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>if"] = "@function.outer",
                        ["<leader>iF"] = "@class.outer",
                    },
                },
            },
        },
        config = function(_, opts)
            local ts_repeat_move =
                require("nvim-treesitter.textobjects.repeatable_move")

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            vim.keymap.set(
                { "n", "x", "o" },
                ";",
                ts_repeat_move.repeat_last_move_next
            )
            vim.keymap.set(
                { "n", "x", "o" },
                ",",
                ts_repeat_move.repeat_last_move_previous
            )

            -- vim way: ; goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- This repeats the last query with always previous direction and to the start of the range.
            -- vim.keymap.set({ "n", "x", "o" }, "<home>", function()
            --   ts_repeat_move.repeat_last_move({forward = false, start = true})
            -- end)

            -- This repeats the last query with always next direction and to the end of the range.
            -- vim.keymap.set({ "n", "x", "o" }, "<end>", function()
            --   ts_repeat_move.repeat_last_move({forward = true, start = false})
            -- end)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
