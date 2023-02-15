" Show relative numbers in visual mode only
function ToggleNumbers()
    set number!
    set relativenumber!
endfunction
augroup VisualEvent
  autocmd!
  " on visual mode enter
  autocmd ModeChanged *:[vV\x16]* call ToggleNumbers()
  " on visual mode leave
  autocmd Modechanged [vV\x16]*:* call ToggleNumbers()
augroup END

" Change keyboard layout on switching mode
function Insert_Leave()
    let $vimlayout=system('xkb-switch -p')
    !xkb-switch -s us
endfunction
function Insert_Enter()
    if $vimlayout != ""
    !xkb-switch -s $vimlayout
    endif
endfunction
autocmd InsertLeave * silent! call Insert_Leave()
autocmd InsertEnter * silent! call Insert_Enter()
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
