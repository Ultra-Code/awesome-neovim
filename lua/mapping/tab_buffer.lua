require('utils')
-- === Moving around, tabs, windows and buffers === --

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
map('t', '<A-h>', [[<C-\><C-N><C-w>h]])
map('t', '<A-j>', [[<C-\><C-N><C-w>j]])
map('t', '<A-k>', [[<C-\><C-N><C-w>k]])
map('t', '<A-l>', [[<C-\><C-N><C-w>l]])
map('i', '<A-h>', [[<C-\><C-N><C-w>h]])
map('i', '<A-j>', [[<C-\><C-N><C-w>j]])
map('i', '<A-k>', [[<C-\><C-N><C-w>k]])
map('i', '<A-l>', [[<C-\><C-N><C-w>l]])
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')

-- Close the current buffer
local opt = {noremap = false}
map('', '<leader>bd', ':bdelete<cr>', opt)

-- Close all the buffers
map('', '<leader>ba', ':bufdo bd<cr>', opt)

map('', '<leader>bn', ':bnext<cr>', opt)
map('', '<leader>bp', ':bprevious<cr>', opt)
map('', '<leader>bf', ':bfirst<cr>', opt)
map('', '<leader>bl', ':blast<cr>', opt)

-- Useful mappings for managing tabs
map('', '<leader>tnw', ':tabnew<cr>', opt)
map('', '<leader>to', ':tabonly<cr>', opt)
map('', '<leader>tc', ':tabclose<cr>', opt)
map('', '<leader>tm', ':tabmove', opt)
map('', '<leader>tn', ':tabnext<cr>', opt)
map('', '<leader>tp', ':tabprevious<cr>', opt)
map('', '<leader>tf', ':tabfirst<cr>', opt)
-- pass a positive or negative argument to the command to move by that step--
map('', '<leader>t', ':tabnext', opt)

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map('', '<leader>te', ':tabedit <c-r>=expand("%:p:h")<cr><cr>', opt)

-- Switch CWD to the directory of the open buffer
map('', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', opt)
