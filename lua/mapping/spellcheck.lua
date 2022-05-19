require("utils")
-- === Spell checking === "
-- For help on spell checking :help spell

-- Pressing ,ts will toggle and untoggle spell checking
-- toggle to alternate configuration of spellcheck
local opt = { remap = true }
local mode = { "n", "v", "o" }
map(mode, "<leader>st", "<cmd>set spell!<cr>", opt)

-- Use Ctrl-x s to activate spell suggestions in insert mood

-- Shortcuts using <leader>
-- next spellcheck iteam
map(mode, "<leader>sn", "]s", opt)
-- previous spellcheck iteam
map(mode, "<leader>sp", "s[", opt)
-- mark word as good in local spellfile :NOTE checkout zG for internal spellfile
map(mode, "<leader>sg", "gz", opt)
-- mark word as wrong in local spellfile :NOTE checkout zW for internal spellfile
map(mode, "<leader>sw", "wz", opt)
-- undo marking of word as good
map(mode, "<leader>usg", "ugz", opt)
-- undo marking of word as wrong
map(mode, "<leader>usw", "uwz", opt)
-- check for suggestions for the underlined word
map(mode, "<leader>sc", "z=", opt)
