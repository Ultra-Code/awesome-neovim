local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
    },
    -- automatically check for plugin updates
    checker = { enabled = false },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        -- get a notification when changes are found
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                -- Vim plugin for editing compressed files.
                "gzip",
                -- tarPlugin.vim -- a Vim plugin for browsing tarfiles
                "tarPlugin",
                -- Vim plugin for converting a syntax highlighted file to HTML.
                "tohtml",
                -- zipPlugin.vim: Handles browsing zipfiles
                "zipPlugin",
                -- netrwPlugin.vim: Handles file transfer and remote directory listing across a network
                -- support of plugins written in other languages
                "netrwPlugin",
                "rplugin",
                -- Vim plugin for downloading spell files
                -- "spellfile",
                -- matchit.vim: (global plugin) Extended "%" matching
                -- "matchit",
                -- Vim plugin for showing matching parens
                -- "matchparen",
                -- "tutor",
                -- "man",
                -- "shada",
                -- "health",
                -- "editorconfig",
                -- "nvim",
            },
        },
    },
})
