nnoremap <F5> :FloatermToggle<CR>
tmap <C-q> <C-\><C-n><C-q>
tmap <F5> <C-q> 

" LSP

nnoremap <leader>s <cmd>lua require('spectre').open()<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>

map <Leader>lb :Telescope diagnostics<CR>

map <Leader>ll :Lspsaga show_line_diagnostics<CR>
map <Leader>ln :Lspsaga diagnostic_jump_next<CR>
map <Leader>lN :Lspsaga diagnostic_jump_prev<CR>

map <Leader>lf :Lspsaga lsp_finder<CR>
map <Leader>la :Lspsaga code_action<CR>
map <Leader>ld :Lspsaga hover_doc<CR>
map <Leader>lr :Lspsaga rename<CR>
