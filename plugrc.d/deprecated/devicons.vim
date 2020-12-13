" loading the plugin
let g:webdevicons_enable = 1

" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1

" adding the custom source to unite
"let g:webdevicons_enable_unite = 1

" adding the column to vimfiler
"let g:webdevicons_enable_vimfiler = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" ctrlp glyphs
"let g:webdevicons_enable_ctrlp = 1

" adding to vim-startify screen
"let g:webdevicons_enable_startify = 1

" adding to flagship's statusline
"let g:webdevicons_enable_flagship_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
"let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" Adding the custom source to denite
"let g:webdevicons_enable_denite = 1

" The amount of space to use after the glyph character in vim-airline tabline(default '')
 let g:WebDevIconsTabAirLineAfterGlyphPadding = ' '

" The amount of space to use before the glyph character in vim-airline tabline(default ' ')
 let g:WebDevIconsTabAirLineBeforeGlyphPadding = ' '

"Character Mapping
" change the default character when no match found
"let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" set a byte character marker (BOM) utf-8 symbol when retrieving file encoding
" disabled by default with no value
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1

" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" enable custom folder/directory glyph exact matching
" (enabled by default when g:WebDevIconsUnicodeDecorateFolderNodes is set to 1)
let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

" change the default folder/directory glyph/icon
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''

" change the default open folder/directory glyph/icon (default is '')
let g:DevIconsDefaultFolderOpenSymbol=''

" change the default dictionary mappings for file extension matches
" Custom icons for file extensions
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = 'ﯤ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = 'ﬥ'


" change the default dictionary mappings for exact file node matches
" Custom icons for specific filenames
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['ormconfig.js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.env'] = 'ﭩ'
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.editorconfig'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.npmrc'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['src'] = ''


" add or override pattern matches for filetypes
" these take precedence over the file extensions
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*jquery.*\.js$'] = 'ƛ'
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.test.ts'] = 'ﭧ'

let g:WebDevIconsOS = 'Linux'

