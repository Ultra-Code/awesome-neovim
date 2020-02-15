"To have most interactive features automatically mapped for you int
"the buffers which have a language server enable
let g:lsc_auto_map = v:true

"avoid suppressing error messages from this plugin.
set shortmess-=F

"Map a filetype to the command that starts the language server for that filetype
let g:lsc_server_commands = {'dart': 'dart_language_server'}

"To enable autocomplete in favor of manual completion
let g:lsc_enable_autocomplete = v:true

"If the server supports the textDocument/documentHighlight call references to
"the element under the cursor throughout the document will be highlighted

let g:lsc_reference_highlights = v:true
