local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main",
    },
}

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main",
    },
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "cpp",
        "zig",
        "nix",
        "comment",
        "jsonc",
        "lua",
        "vue",
        "typescript",
        "scss",
        "html",
        "norg",
        "norg_table",
        "norg_meta",
        "glsl",
        "vim",
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
