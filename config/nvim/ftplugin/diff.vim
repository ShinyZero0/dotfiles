function! UnRemove()
    if getline(".") =~ "^-"
        exe "normal! ml0r\<space>'l"
    else
        normal! dd
    endif
endfunction
nnoremap dd :call UnRemove()<CR>
