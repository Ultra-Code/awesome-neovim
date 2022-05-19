require("utils")
-- turn terminal to normal mode with escape
-- tnoremap <Esc> <C-\><C-n>:q<CR>

-- open terminal on ctrl+n
function _G.OpenTerminal()
    vim.cmd([[
        split term://zsh
        resize 10
    ]])
end

-- Mapping to open terminal emulator in nvim
map("n", "<m-t>", "<cmd>lua OpenTerminal()<CR>")
