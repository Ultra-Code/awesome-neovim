" Remap leader key to ,
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "."

"Source the various mappings
source   $HOME/.config/nvim/mapping.d/coc_map.vim
source   $HOME/.config/nvim/mapping.d/fzf_map.vim
source   $HOME/.config/nvim/mapping.d/nerdtree_map.vim
source   $HOME/.config/nvim/mapping.d/copy_paste_map.vim
source   $HOME/.config/nvim/mapping.d/visual_fnd_replace_map.vim
source   $HOME/.config/nvim/mapping.d/spellcheck_map.vim
source   $HOME/.config/nvim/mapping.d/tab_buffer_map.vim
source   $HOME/.config/nvim/mapping.d/syntastic_map.vim
source   $HOME/.config/nvim/mapping.d/markdown_preview_map.vim
source   $HOME/.config/nvim/mapping.d/highlighting_map.vim
source   $HOME/.config/nvim/mapping.d/multi_cursor_map.vim
source   ~/.config/nvim/mapping.d/folding_map.vim
source   ~/.config/nvim/mapping.d/dart_map.vim
source   ~/.config/nvim/mapping.d/prettier_map.vim
source   ~/.config/nvim/mapping.d/terminal_map.vim
source   ~/.config/nvim/mapping.d/ultisnip_map.vim
