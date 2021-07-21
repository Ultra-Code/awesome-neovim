require('utils')

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif require'luasnip'.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif require'luasnip'.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end
local opt = {noremap = false ,expr = true}
map("i", "<Tab>", "v:lua.tab_complete()", opt)
map("s", "<Tab>", "v:lua.tab_complete()", opt)
map("i", "<S-Tab>", "v:lua.s_tab_complete()", opt)
map("s", "<S-Tab>", "v:lua.s_tab_complete()", opt)
