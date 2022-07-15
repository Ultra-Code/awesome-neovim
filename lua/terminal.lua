local autocmd = vim.api.nvim_create_autocmd -- create autocmd
local autogroup = vim.api.nvim_create_augroup -- create autocmd group

-- open new split panes to right and below
vim.go.splitright = true
vim.go.splitbelow = true

-- define autocmd in a group so that you can clear it easily
local Terminal = autogroup("Terminal", { clear = true })

autocmd({ "TermOpen" }, {
    group = Terminal,
    pattern = { "*" },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.api.nvim_command("startinsert")
    end,
})
