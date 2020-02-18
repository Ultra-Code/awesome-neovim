"    let g:mkdp_path_to_chrome = ""
    "" Path to the chrome or the command to open chrome (or other modern browsers).
    "" If set, g:mkdp_browserfunc would be ignored.

    "let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
    "" Callback Vim function to open browser, the only parameter is the url to open.

    "let g:mkdp_auto_start = 0
    "" Set to 1, Vim will open the preview window on entering the Markdown
    "" buffer.

    "let g:mkdp_auto_open = 0
    "" Set to 1, Vim will automatically open the preview window when you edit a
    "" Markdown file.

    "let g:mkdp_auto_close = 1
    "" Set to 1, Vim will automatically close the current preview window when
    "" switching from one Markdown buffer to another.

    "let g:mkdp_refresh_slow = 0
    "" Set to 1, Vim will just refresh Markdown when saving the buffer or
    "" leaving from insert mode. With default 0, it will automatically refresh
    "" Markdown as you edit or move the cursor.

    "let g:mkdp_command_for_global = 0
    "" Set to 1, the MarkdownPreview command can be used for all files,
    "" by default it can only be used in Markdown files.

    "let g:mkdp_open_to_the_world = 0
    "" Set to 1, the preview server will be available to others in your network.
    "" By default, the server only listens on localhost (127.0.0.1).

    " set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

