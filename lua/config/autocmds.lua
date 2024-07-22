local autocmd = vim.api.nvim_create_autocmd -- create autocmd
local utils = require("config.utils")
local map = utils.map
local augroup = utils.augroup

-- define autocmd in a group so that you can clear it easily
autocmd({ "TermOpen" }, {
    group = augroup("Terminal"),
    pattern = { "*" },
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.api.nvim_command("startinsert")
    end,
})

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("wincmd =")
        vim.cmd("tabdo wincmd =")
    end,
})

-- go to the last known loc/position when opening a file/buffer
-- :h restore-position and :h restore-cursor
autocmd("BufReadPost", {
    group = augroup("restore cursor"),
    pattern = { "*" },
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] >= 1 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>
autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query", -- :InspectTree
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        -- :help api-autocmd
        -- nvim_create_autocmd's callback receives a table argument with fields
        -- event = {id,event,group?,match,buf,file,data(arbituary data)}
        vim.bo[event.buf].buflisted = false
        map(
            "n",
            "q",
            "<cmd>close<cr>",
            { buffer = event.buf, silent = true },
            "close some filetype windows with <q>"
        )
    end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown", "norg" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

local diagnostics_options = require("config.defaults").diagnostics_options
-- automatically show diagnostics on current line
autocmd({ "CursorHold" }, {
    callback = function()
        vim.diagnostic.open_float(nil, diagnostics_options.float)
    end,
})

-- Remove Trailing whitespaces in all files
autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]] })

-- Remove Trailing windows carriage return in all files
if vim.fn.has("win64") == 1 or vim.fn.has("wsl") == 1 then
    autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\r$//e]] })
end

-- Enable auto formating at textwidth
autocmd({ "FileType" }, {
    group = augroup("FormatOptions"),
    pattern = { "*" },
    -- INFO: https://stackoverflow.com/questions/16030639/vim-formatoptions-or/16035812#16035812
    -- https://stackoverflow.com/questions/76259118/neovim-vim-optremove-doesnt-actually-change-the-option
    callback = function()
        vim.opt.formatoptions = {
            t = true,
            c = true,
            r = true,
            o = true,
            q = true,
            ["]"] = true,
            j = true,
        }
    end,
})
