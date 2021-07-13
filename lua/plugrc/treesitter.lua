require'nvim-treesitter.configs'.setup {
  ensure_installed = {'cpp','zig','comment','json','haskell','lua','vue','typescript','scss','html'},
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  incremental_selection = {
      enable = true
  },
  indent = {
    enable = true
  },
  autopairs={enable = true}
}
