local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
    },
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "cpp",
        "zig",
        "nix",
        "comment",
        "json",
        "haskell",
        "lua",
        "vue",
        "typescript",
        "scss",
        "html",
        "norg"
    },
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    autopairs = { enable = true },
})
