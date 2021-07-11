--==========================================================
--==             PLUGINS INIT                             ==
--==========================================================
--
local cmd=vim.cmd
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/coc.vim]]
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/markdown_preview.vim]]
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/syntastic.vim]]
cmd[[source  $XDG_CONFIG_HOME/nvim/lua/plugrc/neoformat.vim]]
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/nerdtree_git.vim]]
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/airline.vim]]
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/plugrc/fzf.vim]]
require('plugrc/vista')
require('plugrc/tree')
require('plugrc/lspconfig')
require('plugrc/lualine')
require('gitsigns').setup()
require('plugrc/compe')
require("plugrc/bufferline")
require('nvim-autopairs').setup()
require('plugrc/neomake')
require('plugrc/treesitter')
require('telescope').setup()
require('plugrc/onedark')
require('plugrc/trouble')
require('plugrc/whichkey')
