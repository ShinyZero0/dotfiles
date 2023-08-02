nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = "\\"
lua require("Keys")

map ; :
map Q q
nnoremap <Esc> <cmd>noh<CR>
map <C-s> :w<CR>

" COMMAND LINE

cnoreabbrev pl lua print
cnoreabbrev m +1mark z \| move

" INSERT MODE 

" inoremap <C-left>  <cmd>normal bi<CR>
" inoremap <C-right> <cmd>normal ea<CR>

" MISC PLUGINS

" nnoremap <F5> <cmd>ToggleTerm direction=vertical size=70<CR>
" nnoremap <Leader>x <cmd>ToggleTermSendCurrentLine<CR>
" vnoremap <Leader>x <cmd>ToggleTermSendVisualLines<CR>
" nnoremap <F5> <cmd>FloatermToggle<CR>

" map <Leader>l <cmd>GrappleCycle forward<CR>
" map <Leader>h <cmd>GrappleCycle backward<CR>

" nnoremap <C-h> :HunkLineToggle<CR>

" 0 TO FIRST WORD

nnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
xnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
onoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'

" I and A to right indent

nnoremap <expr> I getline('.') =~ '^\s*$' ? 'S' : 'I'
nnoremap <expr> A getline('.') =~ '^\s*$' ? 'S' : 'A'

" xmap <leader>c <cmd>lua ToggleMostComments(vim.fn.visualmode())<CR>
