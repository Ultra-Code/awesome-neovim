require('utils')
vim.g.kommentary_create_default_mappings = false
local opt = {noremap=false}
map("n", "gcc", "<cmd>packadd kommentary<cr>|<Plug>kommentary_line_default<cr>", opt)
map("n", "gc", "<cmd>packadd kommentary<cr>|<Plug>kommentary_motion_default<cr>", opt)
map("x", "gc", "<cmd>packadd kommentary<cr>|<Plug>kommentary_visual_default<cr>", opt)
