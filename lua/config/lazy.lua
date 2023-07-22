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
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = { enabled = false }, -- automatically check for plugin updates
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip", -- Vim plugin for editing compressed files.
                "tarPlugin", -- tarPlugin.vim -- a Vim plugin for browsing tarfiles
                "tohtml", -- Vim plugin for converting a syntax highlighted file to HTML.
                "zipPlugin", -- zipPlugin.vim: Handles browsing zipfiles
                "netrwPlugin", -- netrwPlugin.vim: Handles file transfer and remote directory listing across a network
                "rplugin", -- support of plugins written in other languages
                -- "spellfile",   -- Vim plugin for downloading spell files
                -- "matchit",  -- matchit.vim: (global plugin) Extended "%" matching
                -- "matchparen", -- Vim plugin for showing matching parens
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
