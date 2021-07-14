local saga_cfg = {
    use_saga_diagnostic_sign = false,
    finder_action_keys = {
        open = 'o',
        vsplit = 'v',
        split = 's',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>' -- quit can be a table
    },
    code_action_keys = {quit = 'q', exec = '<CR>'},
    rename_action_keys = {
        quit = 'q',
        exec = '<CR>' -- quit can be a table
    },
    -- "single" "double" "round" "plus"
    border_style = "round"
}
return saga_cfg
