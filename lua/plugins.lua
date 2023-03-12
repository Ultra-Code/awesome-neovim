-- ============================================================================ --
-- ===                               PLUGINS                                === --
-- ============================================================================ --
-- PLUGINS FOR NEOVIM
-- Specify a directory for plugins
---For Neovim: ~/.local/share/nvim/site/pack/
require("paq")({

    { "savq/paq-nvim" },

    -- === Editor Plugins === --
    -- A commenter for different Language
    { "numToStr/Comment.nvim" },

    -- === Themes and Colour Scheme ===
    { "navarasu/onedark.nvim" },

    -- === Git Plugin ===
    -- A vim plugin which shows git diff in the gutter (sign column).
    { "lewis6991/gitsigns.nvim" },

    -- === Status Line ===
    -- Status bar plugin
    -- A blazing fast and easy to configure neovim statusline
    { "nvim-lualine/lualine.nvim" },
    -- Tabline
    -- A snazzy buffer line (with minimal tab integration) for Neovim
    { "akinsho/bufferline.nvim" },

    -- === Fuzzy Finder ===
    -- a highly extendable fuzzy finder over lists
    { "nvim-lua/plenary.nvim",         opt = true }, -- reusable lua funtions
    { "nvim-telescope/telescope.nvim", opt = true },

    -- === Syntax Plugins ===
    -- Nvim Treesitter configurations and abstraction layer
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd("TSUpdate")
        end,
    },

    -- === Preview Plugin ===
    -- === Note Taking Plugin ===
    {
        "nvim-neorg/neorg",
        run = function()
            vim.cmd("Neorg sync-parsers")
        end,
        opt = true
    },

    -- === Language Specific Plugins ===
    -- == LSP Client ===
    -- Nvim LSP client
    { "neovim/nvim-lspconfig" },
    -- A pretty diagnostics, references, telescope
    -- results, quickfix and location
    -- list to help you solve all the trouble your code is causing
    { "folke/trouble.nvim",             opt = true },

    --Use Neovim as a language server to inject LSP diagnostics, code actions,
    --and more via Lua
    { "jose-elias-alvarez/null-ls.nvim" },

    -- displays a popup with possible key bindings
    -- of the command you started typing
    { "folke/which-key.nvim" },

    -- == Auto Completions Engine ==
    { "hrsh7th/nvim-cmp" },
    -- Autocompletion plugin
    -- Completion Sources --
    "hrsh7th/cmp-nvim-lsp",                -- nvim-cmp source for neovim builtin LSP client
    "hrsh7th/cmp-path",                    -- nvim-cmp source for path
    "hrsh7th/cmp-buffer",                  -- nvim-cmp source for buffer words
    "hrsh7th/cmp-nvim-lua",                -- nvim-cmp source for nvim lua
    "hrsh7th/cmp-emoji",                   -- nvim-cmp source for emoji
    "hrsh7th/cmp-cmdline",                 --nvim-cmp source for vim's cmdline.
    "hrsh7th/cmp-nvim-lsp-signature-help", --cmp-nvim-lsp-signature-help

    -- Auto pairs
    { "windwp/nvim-autopairs" },

    -- === Code Snippets Plugins ===
    { "L3MON4D3/LuaSnip" },     -- snippets provider for lua
    "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp

    -- === LSP symbols ===
    -- View and search LSP symbols, tags in Vim/NeoVim.--
    { "simrat39/symbols-outline.nvim", opt = true },

    -- === UI === --
    -- A Neovim File explorer
    { "nvim-tree/nvim-tree.lua",       opt = true },

    -- == Icons == --
    -- Glyphs and Icons for neovim
    { "nvim-tree/nvim-web-devicons" },
})
