nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = "\\"
map ; :
nnoremap <Esc> :noh<CR>

nnoremap g1 1gt
nnoremap g2 2gt
nnoremap g3 3gt
nnoremap g4 4gt
nnoremap g5 5gt
nnoremap g6 6gt
nnoremap g7 7gt
nnoremap g8 8gt
nnoremap g9 9gt

map <C-s> :w<CR>
map <C-q> :q<CR>

map <Leader>y "+y
map <Leader>p "+p
vnoremap <Leader>y "+y

nnoremap <Leader>v ^v$h

nnoremap <CR>   o<Esc>
nnoremap <S-CR> O<Esc>

" Command Line

"" set verymagic regex search
nnoremap /  /\v

cnoremap <C-left>  <S-left>
cnoremap <C-right> <S-right>

cnoremap <C-BS> <C-w>

" INSERT MODE 

inoremap <C-left>  <Esc>ba
inoremap <C-right> <Esc>wa

" MISC PLUGINS

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

map ? <cmd>HopPatternMW<CR>
map <C-f> <cmd>HopWordMW<CR>

nnoremap <C-h> :HunkLineToggle<CR>

" TELESCOPE

nnoremap <Leader>t <cmd>Neotree toggle float reveal<CR>
nnoremap <Leader>. <cmd>Neoformat<CR>

" map <Leader>// :Telescope<CR>
" map <Leader>/h :Telescope heading<CR>
" map <Leader>/g :Telescope live_grep<CR>
" map <Leader>/h :Telescope help_tags<CR>

nnoremap <Leader>f :Telescope find_files<CR>
" map <Leader>e :Telescope file_browser<CR>
" map <Leader>b :Telescope buffers<CR>
" map <Leader>t :NeoTreeFloatToggle<CR>

" map ? :Telescope current_buffer_fuzzy_find<CR>

" LITERAL NAVIGATION

nnoremap <C-left>  g0
nnoremap <C-right> g$
nnoremap <C-up>    gk
nnoremap <C-down>  gj

" 0 TO FIRST WORD

nnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
xnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
onoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'

" SPLITTER

nnoremap gs <Nop>
nnoremap <silent> gss ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
nnoremap <silent> gsip mlvip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
vnoremap <silent> gs ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
