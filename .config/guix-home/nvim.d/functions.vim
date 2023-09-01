" FUNCTIONS AND AUTOCOMMANDS

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

function! SourceIfExists(file)
	if filereadable(expand(a:file))
		exe "source " a:file
	endif
endfunction

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

function SelectAll()
	let curMode = mode()
	if curMode == "V"
		call feedkeys("\<Esc>ggVG", "n")
	else
		call feedkeys("A", 'n')
	endif
endfunction
xnoremap A <cmd>call SelectAll()<CR>
