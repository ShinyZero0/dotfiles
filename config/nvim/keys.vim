nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = "\\"
map ; :
nnoremap <Esc> :noh<CR>

imap <C-z> <Esc>ua
imap <C-я> <C-z>

map g1 1gt
map g2 2gt
map g3 3gt
map g4 4gt
map g5 5gt
map g6 6gt
map g7 7gt
map g8 8gt
map g9 9gt

map <C-s>     :w<CR>
map <C-q>     :q<CR>
map <Leader>y "+y
map <Leader>p "+p

" TELESCOPE
map <Leader>/ :Telescope<CR>
map <Leader>f :Telescope find_files<CR>
map <Leader>e :Telescope file_browser<CR>
map <Leader>b :Telescope buffers<CR>
map ? :Telescope current_buffer_fuzzy_find<CR>

" LEAP

map <C-f> <Plug>(leap-forward-to)

" EASYALIGN

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" LITERAL NAVIGATION

nnoremap <C-left>  g0
nnoremap <C-right> g$
nnoremap <C-up>    gk
nnoremap <C-down>  gj

" 0 TO FIRST WORD

nnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
xnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
onoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'

" COMMAND LINE MODE 

cnoremap <C-left>  <S-left>
cnoremap <C-right> <S-right>
cnoremap <C-BS> <C-w>
cnoremap <C-v> <C-r>+

" INSERT MODE 

inoremap <C-left>  <Esc>ba
inoremap <C-right> <Esc>wa
inoremap <C-v> <Esc>pa

" SPLITTER

nnoremap gs <Nop>
vnoremap <silent> gs ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
nnoremap <silent> gss ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
nnoremap <silent> gsip mlvip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l