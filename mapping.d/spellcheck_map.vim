" === Spell checking === "
" For help on spell checking :help spell

" Pressing ,st will toggle and untoggle spell checking
map <leader>st :setlocal spell!<cr> "toggle to alternate configuration of spellcheck

" Shortcuts using <leader>
map <leader>sn ]s  "next spellcheck iteam
map <leader>sp [s  "previous spellcheck iteam
map <leader>sg zg  "mark word as good in local spellfile :NOTE checkout zG for internal spellfile
map <leader>sw zw  "mark word as wrong in local spellfile :NOTE checkout zW for internal spellfile
map <leader>usg zug "undo marking of word as good
map <leader>usw zuw "undo marking of word as wrong
map <leader>sc z=   "check for suggestions for the underlined word
