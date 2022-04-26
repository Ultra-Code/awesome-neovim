-- Using lua functions
require("utils")
local opt = { silent = true }
map(
    "n",
    "<leader>ff",
    [[<cmd>packadd popup.nvim<cr>|<cmd>packadd telescope.nvim<cr>|<cmd>lua require('telescope.builtin').find_files()<cr>]],
    opt
)
map(
    "n",
    "<leader>fg",
    [[<cmd>packadd popup.nvim<cr>|<cmd>packadd telescope.nvim<cr>|<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    opt
)
map(
    "n",
    "<leader>fh",
    [[<cmd>packadd popup.nvim<cr>|<cmd>packadd telescope.nvim<cr>|<cmd>lua require('telescope.builtin').help_tags()<cr>]],
    opt
)
map(
    "n",
    "<leader>fc",
    [[<cmd>packadd popup.nvim<cr>|<cmd>packadd telescope.nvim<cr>|<cmd>lua require('telescope.builtin').command_history()<cr>]],
    opt
)
map(
    "n",
    "<leader>fr",
    [[<cmd>packadd popup.nvim<cr>|<cmd>packadd telescope.nvim<cr>|<cmd>lua require('telescope.builtin').reloader()<cr>]],
    opt
)
