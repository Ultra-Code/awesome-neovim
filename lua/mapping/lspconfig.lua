-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
  local function set_keymap(...) vim.api.nvim_set_keymap(...) end
  local function set_option(...) vim.api.nvim_set_option(...) end

  --Enable completion triggered by <c-x><c-o>
  set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  set_keymap('n', '<leader>gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap('n', '<leader>aw', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  set_keymap('n', '<leader>rw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  set_keymap('n', '<leader>lw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- lsp provider to find the cursor word definition and reference
vim.cmd[[
    nnoremap <silent> <leader>gdr <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
]]

-- code action
vim.cmd[[
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
]]

-- show hover doc
vim.cmd [[
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
]]

-- scroll down hover doc or scroll in definition preview
vim.cmd[[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]]

-- scroll up hover doc
vim.cmd[[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]]

-- show signature help
vim.cmd[[nnoremap <silent> <leader>gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]]

-- rename
vim.cmd[[nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>]]

-- preview definition
vim.cmd[[nnoremap <silent> <leader>pd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>]]

-- jump diagnostic
vim.cmd[[nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]]
vim.cmd[[nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]]

-- only show diagnostic if cursor is over the area
vim.cmd[[nnoremap <silent><leader>scd <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>]]

-- show line diagnostic
vim.cmd[[nnoremap <silent><leader>sld <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]]

-- float terminal also you can pass the cli command in open_float_terminal function
vim.cmd[[nnoremap <silent> <A-t> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> ]]

-- or open_float_terminal('lazygit')<CR>
vim.cmd[[tnoremap <silent> <A-t> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]]
