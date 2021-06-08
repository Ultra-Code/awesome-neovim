-- Using lua functions
local map=vim.api.nvim_set_keymap
local options={noremap=true,silent=true}
map('n','<leader>ff',[[<cmd>lua require('telescope.builtin').find_files()<cr>]] ,options)
map('n','<leader>fg',[[<cmd>lua require('telescope.builtin').live_grep()<cr>]] ,options)
map('n','<leader>fb',[[<cmd>lua require('telescope.builtin').buffers()<cr>]] ,options)
map('n','<leader>fh',[[<cmd>lua require('telescope.builtin').help_tags()<cr>]],options)
