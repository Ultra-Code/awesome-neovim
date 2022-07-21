-- Using lua functions
require("utils")
local opt = { silent = true }

local function telescopesetup()
    vim.cmd([[
    packadd popup.nvim
    packadd telescope.nvim
    ]])

    local actions = require("telescope.actions")
    require("telescope").setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-[>"] = actions.close
                },
                n = {
                    ["<C-[>"] = actions.close
                },
            },
            vimgrep_arguments = {
                -- "grep", "--extended-regexp", "--color=never", "--with-filename", "--line-number", "-b", -- grep doesn't support a `--column` option :(
                -- "--ignore-case", "--recursive", "--no-messages", "--exclude-dir=*cache*", "--exclude-dir=*.git",
                -- "--exclude=.*", "--binary-files=without-match"
                "git", "grep", "--full-name", "--line-number", "--column", "--extended-regexp", "--ignore-case",
                "--no-color", "--recursive", "--recurse-submodules", "-I"
            },
        }
    }
end

-- File Pickers
--Lists files in your current working directory, respects .gitignore
map("n", "<leader>ff",
    --Falling back to find_files if git_files can't find a .git directory
    function()
        telescopesetup()
        local opts = {} -- define here if you want to define something
        local ok = pcall(require "telescope.builtin".git_files, opts)
        if not ok then require "telescope.builtin".find_files(opts) end
    end, opt)

--Searches for the string under your cursor in your current working directory
map("n", "<leader>gs",
    function()
        telescopesetup()
        return require('telescope.builtin').grep_string()
    end, opt)

-- Search for a string in your current working directory and get results live as you type (respecting .gitignore)
map("n", "<leader>lg",
    function()
        telescopesetup()
        return require('telescope.builtin').live_grep()
    end, opt)


--Vim Pickers
--Lists previously open files
map("n", "<leader>of",
    function()
        telescopesetup()
        return require('telescope.builtin').oldfiles()
    end, opt)
--Lists available help tags and opens a new window with the relevant help info on <cr>
map("n", "<leader>ht",
    function()
        telescopesetup()
        return require('telescope.builtin').help_tags()
    end, opt)
--Lists vim options, allows you to edit the current value on <cr>
map("n", "<leader>vo",
    function()
        telescopesetup()
        return require('telescope.builtin').vim_options()
    end, opt)
--Lists normal mode keymappings
map("n", "<leader>km",
    function()
        telescopesetup()
        return require('telescope.builtin').keymaps()
    end, opt)
--Live fuzzy search inside of the currently open buffer
map("n", "<leader>sw",
    function()
        telescopesetup()
        return require('telescope.builtin').current_buffer_fuzzy_find()
    end, opt)
--Lists the results incl. multi-selections of the previous picker
map("n", "<leader>rs",
    function()
        telescopesetup()
        return require('telescope.builtin').resume()
    end, opt)
