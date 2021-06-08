--Source the various mappings
local cmd= vim.cmd
cmd[["source  $XDG_CONFIG_HOME/nvim/lua/mapping/coc_map.vim]]
cmd[["source   $XDG_CONFIG_HOME/nvim/lua/mapping/fzf_map.vim]]
cmd[["source   $XDG_CONFIG_HOME/nvim/lua/mapping/nerdtree_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/copy_paste_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/visual_fnd_replace_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/spellcheck_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/tab_buffer_map.vim]]
cmd[["source   $XDG_CONFIG_HOME/nvim/lua/mapping/syntastic_map.vim]]
cmd[["source   $XDG_CONFIG_HOME/nvim/lua/mapping/markdown_preview_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/highlighting_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/folding_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/terminal_map.vim]]
cmd[[source   $XDG_CONFIG_HOME/nvim/lua/mapping/vsnip.vim]]
require('mapping/compe')
require('mapping/lspconfig')
require('mapping/autopairs')
require('mapping/tree')
require('mapping/telescope')
require('mapping/trouble')
require('mapping/vista')
