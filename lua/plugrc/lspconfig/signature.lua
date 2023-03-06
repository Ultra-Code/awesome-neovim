local signature_cfg = {
    -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    bind = true,
    -- will show the specified lines of comment/doc (if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown. This setting only take effect in insert mode,
    -- it does not affect signature help in normal mode, 10 by default
    doc_lines = 18,
    -- max height of signature floating_window,
    -- if content is more than max_height, you can scroll down to view the hiding contents
    max_height = 18,
    -- max_width of signature floating_window,
    -- line will be wrapped if exceed max_width
    max_width = 117,
    -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    wrap = true,
    -- show hint in a floating window,
    -- set to false for virtual text only mode
    floating_window = true,
    -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap
    floating_window_above_cur_line = true,
    floating_window_off_x = 5, -- adjust float windows x position.
    -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
    floating_window_off_y = function()
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline()                 -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then
            return pumheight
        end

        -- window bottom
        if winheight - winline < pumheight then
            return -pumheight
        end
        return 0
    end,
    -- set to true the floating window will not auto-close until finish all parameters
    -- It can be a boolean or a function that returns a boolean
    fix_pos = true,
    hint_enable = true,                           -- virtual hint enable
    hint_prefix = "🐼 ",                        -- Panda for parameter
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        -- double, rounded, single, shadow, none, or a table of borders
        border = "shadow",
    },
    -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
    always_trigger = false,
    auto_close_after = nil,     -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {},   -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 400,               -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
    padding = '',               -- character to pad on left and right of signature can be ' ', or '|'  etc
    transparency = nil,         -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36,          -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black',     -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200,       -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil,           -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil,      -- imap, use nvim_set_current_win to move cursor between current win and floating
}

return signature_cfg
