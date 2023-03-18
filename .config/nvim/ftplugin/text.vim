set linebreak
silent! %s/ | / /g
silent! %s/ \+/ /g
silent! %s/—/-/g
" au BufWritePre * mark z | silent! %s/--/—/g | silent! %s/--/—/g
" au BufWritePost * silent! undo | normal! 'z
" nnoremap <Leader>. <Nop>
" nnoremap <leader>.s <cmd>Neoformat Split<CR>
" nnoremap <leader>.j <cmd>Neoformat Join<CR>
