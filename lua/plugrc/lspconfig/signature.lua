local signature_cfg = {
    -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    bind = true,
    -- will show the specified lines of comment/doc (if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown. This setting only take effect in insert mode,
    -- it does not affect signature help in normal mode, 10 by default
    doc_lines = 18,
    -- show hint in a floating window,
    floating_window = true,
    -- set to false for virtual text only mode
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap
    -- set to true, the floating window will not auto-close until finish all parameters
    fix_pos = false,
    hint_enable = true,      -- virtual hint enable
    hint_prefix = "🐼 ",   -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = false,     -- set to true if you want to use lspsaga popup
    hi_parameter = "Search", -- how your parameter will be highlight
    -- max height of signature floating_window,
    -- if content is more than max_height, you can scroll down to view the hiding contents
    max_height = 18,
    -- max_width of signature floating_window,
    -- line will be wrapped if exceed max_width
    max_width = 117,
    handler_opts = {
        border = "shadow",    -- double, single, shadow, none
    },
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
}

return signature_cfg
