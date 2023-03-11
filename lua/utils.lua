function _G.map(mode, lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, opts)
end

function _G.dump(...)
    vim.pretty_print(...);
end

function _G.reloadAllModules()
    for name, _ in pairs(package.loaded) do
        if name:match("^lazy")
            or name:match("^mapping")
            or name:match("^plugrc")
            or name:match("^ui")
            or name:match("^editor")
            or name:match("^plugins")
            or name:match("^syntax")
            or name:match("^terminal")
            or name:match("^utils")
        then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
end

function _G.reload(module)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. module) then
            package.loaded[name] = nil
            require(name)
            return
        end
    end
end

local M = {}

-- options from nvim_open_win()| vim.diagnostic.open_float()
-- | vim.lsp.util.open_floating_preview()| vim.diagnostic.config()
M.diagnostics_options = {
    virtual_text = false,
    float = {
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        focusable = false,
        focus = false,
        source = "if_many",
        -- "single": A single line box.
        -- "double": A double line box.
        -- "rounded": Like "single", but with rounded corners "╭"
        -- "solid": Adds padding by a single whitespace cell.
        -- "shadow": A drop shadow effect by blending with the
        -- "none": No border (default).
        border = "rounded",
    },
    update_in_insert = false,
    severity_sort = true,
}
return M;
