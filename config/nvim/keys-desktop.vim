let mapleader = " "
nnoremap <F5> :FloatermToggle<CR>
tmap <C-q> <C-\><C-n><C-q>
tmap <F5> <C-q> 

" LSP

nnoremap <leader>s <cmd>lua require('spectre').open()<CR>
vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>

" nnoremap <Leader>lb :Telescope diagnostics<CR>

" nnoremap <Leader>ll :Lspsaga show_line_diagnostics<CR>
" nnoremap <Leader>ln :Lspsaga diagnostic_jump_next<CR>
" nnoremap <Leader>lN :Lspsaga diagnostic_jump_prev<CR>

" nnoremap <Leader>lf :Lspsaga lsp_finder<CR>
" nnoremap <Leader>la :Lspsaga code_action<CR>
" nnoremap <Leader>ld :Lspsaga hover_doc<CR>
" nnoremap <Leader>lr :Lspsaga rename<CR>
