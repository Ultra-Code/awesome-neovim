--TODO: use immediately invoked function expression for vimgrep_arguments .ie
--(fn()statement end)()
--HACK: move mappings from previous configuration here
--https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__files.lua
--HELP: telescope nvim
local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    ---@diagnostic disable-next-line: undefined-field
    return vim.v.shell_error == 0
end
-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local telescope_builtin = function(builtin, opts)
    local params = { builtin = builtin, opts = opts or {} }

    return function()
        builtin = params.builtin
        opts = params.opts
        if builtin == "files" then
            if is_git_repo() then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
            -- live_grep_from_project_git_root
            -- TODO: test with and without the `get_git_root`
        elseif builtin == "live_grep" then
            local function get_git_root()
                local dot_git_path = vim.fn.finddir(".git", ".;")
                return vim.fn.fnamemodify(dot_git_path, ":h")
            end

            if is_git_repo() then
                opts.cwd = get_git_root()
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

return {
    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            {
                "<leader>,",
                telescope_builtin("buffers", { show_all_buffers = true }),
                desc = "Switch Buffer",
            },
            {
                "<leader>fb",
                telescope_builtin("buffers"),
                desc = "Buffers",
            },
            {
                "<leader>:",
                telescope_builtin("command_history"),
                desc = "Command History",
            },
            -- find
            {
                "<leader><space>",
                telescope_builtin("files"),
                desc = "Find Files (root dir)",
            },
            {
                "<leader>ff",
                telescope_builtin("files"),
                desc = "Find Files (root dir)",
            },
            {
                "<leader>fr",
                telescope_builtin("oldfiles"),
                desc = "Recent",
            },
            -- git
            {
                "<leader>gc",
                telescope_builtin("git_commits"),
                desc = "commits",
            },
            {
                "<leader>gs",
                telescope_builtin("git_status"),
                desc = "status",
            },
            -- search
            {
                "<leader>sa",
                telescope_builtin("autocommands"),
                desc = "Auto Commands",
            },
            {
                "<leader>sb",
                telescope_builtin("current_buffer_fuzzy_find"),
                desc = "Buffer",
            },
            {
                "<leader>sc",
                telescope_builtin("command_history"),
                desc = "Command History",
            },
            {
                "<leader>sC",
                telescope_builtin("commands"),
                desc = "Commands",
            },
            {
                "<leader>/",
                telescope_builtin("live_grep"),
                desc = "Find in Files (Grep)",
            },
            {
                "<leader>sg",
                telescope_builtin("live_grep"),
                desc = "Grep (root dir)",
            },
            {
                "<leader>sh",
                telescope_builtin("help_tags"),
                desc = "Help Pages",
            },
            {
                "<leader>sH",
                telescope_builtin("highlights"),
                desc = "Search Highlight Groups",
            },
            {
                "<leader>sk",
                telescope_builtin("keymaps"),
                desc = "Key Maps",
            },
            {
                "<leader>sM",
                telescope_builtin("man_pages"),
                desc = "Man Pages",
            },
            {
                "<leader>sm",
                telescope_builtin("marks"),
                desc = "Jump to Mark",
            },
            {
                "<leader>so",
                telescope_builtin("vim_options"),
                desc = "Options",
            },
            {
                "<leader>sw",
                telescope_builtin("grep_string"),
                desc = "Word (root dir)",
            },
            {
                "<leader>uC",
                telescope_builtin("colorscheme", { enable_preview = true }),
                desc = "Colorscheme with preview",
            },
            {
                "<leader>ss",
                telescope_builtin("lsp_document_symbols"),
                desc = "List Symbols (current buffer)",
            },
            {
                "<leader>sS",
                telescope_builtin("lsp_workspace_symbols"),
                desc = "List Symbols (Workspace)",
            },
            {
                "<leader>sr",
                telescope_builtin("lsp_references"),
                desc = "List LSP references for word under the cursor",
            },
            {
                "<leader>R",
                telescope_builtin("resume"),
                desc = "Resume",
            },
            {
                "<leader>sd",
                telescope_builtin("diagnostics", { bufnr = 0 }),
                desc = "Lists Diagnostics for the current buffer",
            },
            {
                "<leader>sD",
                telescope_builtin("diagnostics"),
                desc = "Lists all Diagnostics for all open buffers",
            },
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        i = {
                            ["<C-[>"] = actions.close,
                            ["<a-i>"] = function()
                                telescope_builtin(
                                    "find_files",
                                    { no_ignore = true }
                                )()
                            end,
                            ["<a-h>"] = function()
                                telescope_builtin(
                                    "find_files",
                                    { hidden = true }
                                )()
                            end,
                            ["<C-Down>"] = function(...)
                                return require("telescope.actions").cycle_history_next(
                                    ...
                                )
                            end,
                            ["<C-Up>"] = function(...)
                                return require("telescope.actions").cycle_history_prev(
                                    ...
                                )
                            end,
                            ["<C-f>"] = function(...)
                                return require("telescope.actions").preview_scrolling_down(
                                    ...
                                )
                            end,
                            ["<C-b>"] = function(...)
                                return require("telescope.actions").preview_scrolling_up(
                                    ...
                                )
                            end,
                        },
                        n = {
                            ["q"] = function(...)
                                return require("telescope.actions").close(...)
                            end,
                            ["<C-[>"] = actions.close,
                        },
                    },
                    vimgrep_arguments = (function()
                        if is_git_repo() then
                            return {
                                "git",
                                "grep",
                                "--full-name",
                                "--line-number",
                                "--column",
                                "--extended-regexp",
                                "--ignore-case",
                                "--no-color",
                                "--recursive",
                                "--recurse-submodules",
                                "-I",
                            }
                        else
                            return {
                                "grep",
                                "--extended-regexp",
                                "--color=never",
                                "--with-filename",
                                "--line-number",
                                "-b", -- grep doesn't support a `--column` option :(
                                "--ignore-case",
                                "--recursive",
                                "--no-messages",
                                "--exclude-dir=*cache*",
                                "--exclude-dir=*.git",
                                "--exclude=.*",
                                "--binary-files=without-match",
                            }
                        end
                    end)(),
                },
            }
        end,
    },
}
