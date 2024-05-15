return {

    -- === UI === --
    -- A Neovim File explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        keys = {
            {
                "<leader>n",
                function()
                    require("nvim-tree.api").tree.toggle({
                        focus = true,
                        find_file = true,
                    })
                end,
                mode = "n",
                silent = true,
                desc = "toggle tree",
            },
        },
        init = function()
            local autocmd = vim.api.nvim_create_autocmd

            autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup(
                    "NvimTreeClose",
                    { clear = true }
                ),
                pattern = "NvimTree_*",
                callback = function()
                    local layout = vim.api.nvim_call_function("winlayout", {})
                    if
                        layout[1] == "leaf"
                        and vim.api.nvim_buf_get_option(
                            vim.api.nvim_win_get_buf(layout[2]),
                            "filetype"
                        ) == "NvimTree"
                        and layout[3] == nil
                    then
                        vim.cmd("confirm quit")
                    end
                end,
            })

            -- when no file/directory is opened at startup
            -- skip nvim-tree so that dashboard can load
            local cmdline_args = -1
            if vim.fn.argc(cmdline_args) == 0 then
                return
            else
                autocmd({ "VimEnter" }, {
                    -- open nvim-tree for noname buffers and directory
                    callback = function(args)
                        -- buffer is a [No Name]
                        local no_name = args.file == ""
                            and vim.bo[args.buf].buftype == ""
                        -- buffer is a directory
                        local directory = vim.fn.isdirectory(args.file) == 1

                        if not directory and not no_name then
                            return
                        end

                        local api = require("nvim-tree.api")

                        if directory then
                            -- change to the directory
                            vim.cmd.cd(args.file)
                            -- open the tree
                            api.tree.open()
                        else
                            -- open the tree, find the file but don't focus it
                            api.tree.toggle({ focus = false, find_file = true })
                        end
                    end,
                })
            end
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
        opts = function(_, _)
            local function on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end
                local map = vim.keymap.set

                -- Default mappings. Feel free to modify or remove as you wish.
                --
                -- BEGIN_DEFAULT_ON_ATTACH
                map("n", "g?", api.tree.toggle_help, opts("Help"))

                map("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
                map("n", "C", api.tree.change_root_to_node, opts("CD"))

                map("n", "E", api.tree.expand_all, opts("Expand All"))
                map("n", "q", api.tree.close, opts("Close"))
                map("n", "R", api.tree.reload, opts("Refresh"))
                map("n", "S", api.tree.search_node, opts("Search"))
                map(
                    "n",
                    "U",
                    api.tree.toggle_custom_filter,
                    opts("Toggle Hidden")
                )
                map(
                    "n",
                    "H",
                    api.tree.toggle_hidden_filter,
                    opts("Toggle Dotfiles")
                )
                map("n", "W", api.tree.collapse_all, opts("Collapse"))

                map(
                    "n",
                    "<C-e>",
                    api.node.open.replace_tree_buffer,
                    opts("Open: In Place")
                )
                map("n", "<CR>", api.node.open.edit, opts("Open"))
                map("n", "o", api.node.open.edit, opts("Open"))
                map(
                    "n",
                    "O",
                    api.node.open.no_window_picker,
                    opts("Open: No Window Picker")
                )

                map("n", "<C-k>", api.node.show_info_popup, opts("File Info"))

                map(
                    "n",
                    "<C-r>",
                    api.fs.rename_sub,
                    opts("Rename: Omit Filename")
                )
                map("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
                map("n", "r", api.fs.rename, opts("Rename File"))
                map("n", "a", api.fs.create, opts("Create File"))
                map("n", "c", api.fs.copy.node, opts("Copy File"))
                map("n", "y", api.fs.copy.filename, opts("Copy Name"))
                map(
                    "n",
                    "Y",
                    api.fs.copy.relative_path,
                    opts("Copy Relative Path")
                )
                map(
                    "n",
                    "gy",
                    api.fs.copy.absolute_path,
                    opts("Copy Absolute Path")
                )
                map("n", "d", api.fs.remove, opts("Delete"))
                map("n", "D", api.fs.trash, opts("Trash"))
                map("n", "p", api.fs.paste, opts("Paste"))
                map("n", "x", api.fs.cut, opts("Cut"))

                map(
                    "n",
                    "<C-v>",
                    api.node.open.vertical,
                    opts("Open: Vertical Split")
                )
                map(
                    "n",
                    "<C-x>",
                    api.node.open.horizontal,
                    opts("Open: Horizontal Split")
                )
                map("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))

                map(
                    "n",
                    "<BS>",
                    api.node.navigate.parent_close,
                    opts("Close Directory")
                )

                map("n", "<Tab>", api.node.open.preview, opts("Open Preview"))

                map(
                    "n",
                    ">",
                    api.node.navigate.sibling.next,
                    opts("Next Sibling")
                )
                map(
                    "n",
                    "<",
                    api.node.navigate.sibling.prev,
                    opts("Previous Sibling")
                )
                map(
                    "n",
                    "J",
                    api.node.navigate.sibling.last,
                    opts("Last Sibling")
                )
                map(
                    "n",
                    "K",
                    api.node.navigate.sibling.first,
                    opts("First Sibling")
                )
                map(
                    "n",
                    "P",
                    api.node.navigate.parent,
                    opts("Parent Directory")
                )
                map("n", "-", api.tree.change_root_to_parent, opts("Up"))

                map("n", ".", api.node.run.cmd, opts("Run File Command"))
                map("n", "s", api.node.run.system, opts("Run System"))

                map("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
                map("n", "m", api.marks.toggle, opts("Toggle Bookmark"))

                map("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
                map("n", "]c", api.node.navigate.git.next, opts("Next Git"))
                map(
                    "n",
                    "B",
                    api.tree.toggle_no_buffer_filter,
                    opts("Toggle No Buffer")
                )
                map(
                    "n",
                    "C",
                    api.tree.toggle_git_clean_filter,
                    opts("Toggle Git Clean")
                )
                map(
                    "n",
                    "I",
                    api.tree.toggle_gitignore_filter,
                    opts("Toggle Git Ignore")
                )

                map(
                    "n",
                    "]e",
                    api.node.navigate.diagnostics.next,
                    opts("Next Diagnostic")
                )
                map(
                    "n",
                    "[e",
                    api.node.navigate.diagnostics.prev,
                    opts("Prev Diagnostic")
                )

                map("n", "F", api.live_filter.clear, opts("Clean Filter"))
                map("n", "f", api.live_filter.start, opts("Filter"))
                -- END_DEFAULT_ON_ATTACH

                --Example of mappings with a custom action_cb
                -- map('n', 'P', function()
                --     local node = api.tree.get_node_under_cursor()
                --     if node ~= nil then
                --         print(node.absolute_path)
                --     end
                -- end, opts('Print Node Path'))
            end

            return {
                on_attach = on_attach,
                -- hijack the cursor in the tree to put it at the start of the filename
                hijack_cursor = true,
                --  reload the explorer every time a buffer is written to
                auto_reload_on_write = true,
                -- Completely disable netrw
                disable_netrw = true,
                -- hijack netrw window on startup
                hijack_netrw = true,
                --  open in place of the unnamed buffer if it's empty.
                hijack_unnamed_buffer_when_opening = true,
                -- hijacks new directory buffers when they are opened (`:e dir`).
                hijack_directories = {
                    -- enable the feature. Disable this option if you use vim-dirvish or dirbuf.nvim.
                    -- If |hijack_netrw| and |disable_netrw| are `false`, this feature will be disabled.
                    enable = true,
                    -- opens the tree if the tree was previously closed.
                    auto_open = true,
                },
                -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
                -- and refresh the tree
                sync_root_with_cwd = false,
                -- Automatically reloads the tree on `BufEnter` nvim-tree.
                reload_on_bufenter = false,
                --Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
                respect_buf_cwd = false,
                -- Use |vim.ui.select| style prompts. Necessary when using a UI prompt decorator
                -- such as dressing.nvim or telescope-ui-select.nvim
                select_prompts = false,
                -- Changes how files within the same directory are sorted.
                -- Can be one of "name", "case_sensitive", "modification_time", "extension",
                -- "suffix", "filetype" or a function. "extension" uses all suffixes e.g. foo.tar.gz -> .tar.gz
                -- "suffix" uses the last e.g. .gz
                sort = {
                    sorter = "name",
                    -- Sort folders before files. Has no effect when |nvim-tree.sort.sorter| is a function
                    folders_first = false,
                    -- Sort files before folders. Has no effect when |nvim-tree.sort.sorter| is a
                    -- function. If set to `true` it overrides |nvim-tree.sort.folders_first|                   folders_first = true,
                    files_first = false,
                },
                -- window / buffer setup
                view = {
                    -- When entering nvim-tree, reposition the view so that the current node is
                    --initially centralized, see |zz|.
                    centralize_selection = false,
                    -- Enable |cursorline| in the tree window.
                    cursorline = true,
                    -- Idle milliseconds before some reload / refresh operations.
                    -- Increase if you experience performance issues around screen refresh.
                    debounce_delay = 30,
                    -- side of the tree, can be 'left' | 'right'
                    side = "left",
                    -- preserve window proportions when opening a file.
                    -- If `false`, the height and width of windows other than nvim-tree will be equalized.
                    preserve_window_proportions = true,
                    -- print the line number in front of each line.
                    number = false,
                    -- show the line number relative to the line with the cursor in front of each line.
                    -- If the option `view.number` is also `true`, the number on the cursor line will be the line number instead of `0`.
                    relativenumber = false,
                    --show diagnostic sign column. Value can be `"yes"`, `"auto"`, `"no"`
                    signcolumn = "yes",
                    -- Width of the window: can be a `%` string, a number representing columns, a
                    -- function or a table.
                    -- A table indicates that the view should be dynamically sized based on the
                    -- longest line (previously `view.adaptive_size`).
                    width = {
                        -- Minimum dynamic width.
                        min = "25%",
                        -- Maximum dynamic width, -1 for unbounded.
                        max = "45%",
                        -- Extra padding to the right.
                        padding = 1,
                    },
                    -- Configuration options for floating window
                    float = {
                        -- Tree window will be floating.
                        enable = false,
                        -- Close the floating tree window when it loses focus.
                        quit_on_focus_loss = true,
                        -- Floating window config. See |nvim_open_win| for more details.
                        open_win_config = {
                            relative = "editor",
                            border = "rounded",
                            width = 30,
                            height = 30,
                            row = 1,
                            col = 1,
                        },
                    },
                },
                -- UI rendering setup
                renderer = {
                    -- Appends a trailing slash to folder names.
                    add_trailing = false,
                    -- Compact folders that only contain a single folder into one node in the file tree.
                    group_empty = false,
                    -- Display node whose name length is wider than the width of nvim-tree window in floating window.
                    full_name = false,
                    -- Number of spaces for an each tree nesting level. Minimum 1.
                    indent_width = 2,
                    -- A list of filenames that gets highlighted with `NvimTreeSpecialFile`.
                    special_files = {
                        "Cargo.toml",
                        "Makefile",
                        "README.md",
                        "build.zig",
                        "build.zig.zon",
                    },
                    -- Whether to show the destination of the symlink.
                    symlink_destination = true,
                    -- Enable file highlight for git attributes using `NvimTreeGit*` highlight groups.
                    -- Requires |nvim-tree.git.enable|
                    highlight_git = true,
                    -- Enable highlight for diagnostics using `LspDiagnosticsError*Text` highlight groups.
                    -- Requires |nvim-tree.diagnostics.enable|
                    highlight_diagnostics = true,
                    -- Highlight icons and/or names for |bufloaded()| files using the
                    -- NvimTreeOpenedFile highlight group.
                    -- See |nvim-tree-api.navigate.opened.next()| and |nvim-tree-api.navigate.opened.prev()|
                    -- Value can be "none", "icon", "name" or "all".
                    highlight_opened_files = "icon",
                    -- Highlight icons and/or names for modified files using the
                    -- `NvimTreeModifiedFile` highlight group.
                    -- Requires |nvim-tree.modified.enable|
                    -- Value can be `"none"`, `"icon"`, `"name"` or `"all"`
                    highlight_modified = "icon",
                    -- Highlight bookmarked using the NvimTreeBookmarkHL group.
                    -- Value can be "none", "icon", "name" or "all"
                    highlight_bookmarks = "name",
                    -- Enable highlight for clipboard items using the NvimTreeCutHL and
                    -- NvimTreeCopiedHL groups.
                    -- Value can be "none", "icon", "name" or "all".
                    highlight_clipboard = "name",
                    -- Configuration options for tree indent markers.
                    indent_markers = {
                        -- Display indent markers when folders are open
                        enable = false,
                        -- Display folder arrows in the same column as indent marker
                        -- when using |renderer.icons.show.folder_arrow|
                        inline_arrows = true,
                        -- Icons shown before the file/directory. Length 1.
                        icons = {
                            corner = "└",
                            edge = "│",
                            item = "│",
                            bottom = "─",
                            none = " ",
                        },
                    },
                },
                -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
                update_focused_file = {
                    -- enables the feature
                    enable = true,
                    -- Update the root directory of the tree if the file is not under current
                    -- root directory. It prefers vim's cwd and `root_dirs`.
                    -- Otherwise it falls back to the folder containing the file.
                    -- Only relevant when `update_focused_file.enable` is `true`
                    update_root = true,
                    -- list of buffer names / filetypes that will not update the cwd if the file
                    -- isn't found under the current root directory
                    -- only relevant when `update_focused_file.update_root` is true and `update_focused_file.enable` is true
                    ignore_list = {},
                },
                -- git integration with icons and colors
                git = {
                    -- enable / disable the feature
                    enable = true,
                    -- Show status icons of children when directory itself has no status icon.
                    show_on_dirs = true,
                    -- Show status icons of children on directories that are open.
                    -- Only relevant when `git.show_on_dirs` is `true`.
                    show_on_open_dirs = true,
                    -- Kills the git process after some time if it takes too long.
                    -- Git integration will be disabled after 10 git jobs exceed this timeout.
                    timeout = 400,
                },
                -- LSP diagnostics
                diagnostics = {
                    enable = true,
                    debounce_delay = 50,
                    show_on_dirs = true,
                    show_on_open_dirs = true,
                    severity = {
                        min = vim.diagnostic.severity.INFO,
                        max = vim.diagnostic.severity.ERROR,
                    },
                },
                -- Indicate which file have unsaved modification
                modified = {
                    -- You will still need to set |renderer.icons.show.modified| `= true` or
                    -- |renderer.highlight_modified| `= true` to be able to see modified status in the tree.
                    enable = true,
                    -- Show modified indication on directory whose children are modified.
                    show_on_dirs = true,
                    -- Show modified indication on open directories.
                    -- Only relevant when |modified.show_on_dirs| is `true`.
                    show_on_open_dirs = true,
                },
                --filtering options
                filters = {
                    -- Ignore files based on `.gitignore`. Requires |git.enable| `= true`
                    -- Toggle via |nvim-tree-api.tree.toggle_gitignore_filter()|
                    git_ignored = true,
                    -- do not show dotfiles: files starting with a `.`
                    -- Toggle via |nvim-tree-api.tree.toggle_hidden_filter()|
                    dotfiles = true,
                    -- Do not show files with no git status. This will show ignored files when
                    -- |nvim-tree.filters.git_ignored| is set, as they are effectively dirty.
                    -- Toggle via |nvim-tree-api.tree.toggle_git_clean_filter()|
                    git_clean = false,
                    -- Custom list of vim regex for file/directory names that will not be shown.
                    -- Backslashes must be escaped e.g. "^\\.git". See |string-match|.
                    -- Toggle via |nvim-tree-api.tree.toggle_custom_filter()|
                    custom = {},
                    --list of directories or files to exclude from filtering: always show them.
                    --Overrides `git.ignore`, `filters.dotfiles` and `filters.custom`.
                    exclude = {},
                },
                --configuration for various actions
                actions = {
                    --When enabled, copied text will be stored in registers '+' (system), otherwise, it will be stored in '1' and '"'.
                    use_system_clipboard = true,
                    -- vim |current-directory| behaviour.
                    change_dir = {
                        --change the working directory when changing directories in the tree.
                        enable = true,
                        -- Use `:cd` instead of `:lcd` when changing directories.
                        -- Consider that this might cause issues with the |nvim-tree.sync_root_with_cwd| option.
                        global = false,
                        --restrict changing to a directory above the global current working directory.
                        restrict_above_cwd = false,
                    },
                    -- Configuration options for opening a file from nvim-tree.
                    open_file = {
                        --closes the explorer when opening a file.
                        --It will also disable preventing a buffer overriding the tree.
                        quit_on_open = true,
                        --resizes the tree when opening a file
                        resize_window = false,
                        --window picker configuration
                        window_picker = {
                            --If not enabled, files will open in window from which you last opened the tree.
                            enable = true,
                        },
                    },
                    -- Close any window displaying a file when removing the file from the tree.
                    remove_file = { close_window = true },
                },
                -- Configuration for tab behaviour.
                tab = {
                    -- Configuration for syncing nvim-tree across tabs.
                    sync = {
                        -- Opens the tree automatically when switching tabpage or opening a new
                        -- tabpage if the tree was previously open.
                        open = false,
                        -- Closes the tree across all tabpages when the tree is closed.
                        close = false,
                    },
                },
            }
        end,
    },
}
