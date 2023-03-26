" ==========================================================

" FUNCTIONS AND AUTOCOMMANDS

cnoreabbrev pl lua print

" open main file for pwd
function MainFile() abort
    call SourceIfExists(".mainfile.vim")
endfunction

function AddMainFile() abort
    let current = expand("%")
    " let bufnr = bufadd(".mainfile.vim")
    " call bufload(bufnr)
    " call setbufline(bufnr, 1, [ "text" ])
    call writefile([ printf("edit %s", current) ], ".mainfile.vim")
    " buffer#
endfunction

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
function SetEnglish()
    let $vimlayout = system('xkb-switch -p')
    !xkb-switch -s us
endfunction
function SetOldLayout()
    if $vimlayout != ""
        !xkb-switch -s $vimlayout
    endif
endfunction

autocmd InsertLeave * silent! call SetEnglish()
autocmd InsertEnter * silent! call SetOldLayout()

" autocmd RecordingEnter * set cmdheight=1
" autocmd RecordingLeave * silent! set cmdheight=0

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
autocmd BufWritePre *.lua Neoformat
" autocmd User MainFile call MainFile()
autocmd VimEnter * call MainFile()

au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown
autocmd BufEnter *.axaml,*.xaml setlocal ft=xml ts=2 sw=2
" autocmd BufEnter * lua require("CheckTrailBlazer")
