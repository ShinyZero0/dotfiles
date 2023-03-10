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
    let $vimlayout = system('xkb-switch -p')
    !xkb-switch -s us
endfunction
function Insert_Enter()
    if $vimlayout != ""
        !xkb-switch -s $vimlayout
    endif
endfunction
autocmd InsertLeave * silent! call Insert_Leave()
autocmd InsertEnter * silent! call Insert_Enter()

function SelectAll()
    let curMode = mode()
    if curMode == "V"
        call feedkeys("\<Esc>ggVG", "n")
    else
        call feedkeys("A", 'n')
    endif
endfunction
vnoremap A <cmd>call SelectAll()<CR>

autocmd FileType * set formatoptions-=cro

" autocmd BufEnter * lua require("CheckTrailBlazer")
