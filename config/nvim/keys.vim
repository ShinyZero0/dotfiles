nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = "\\"
map ; :
nnoremap <Esc> :noh<CR>

imap <C-z> <Esc>ua
imap <C-я> <C-z>

map <C-s> :w<CR>
map <C-q> :q<CR>
map <Leader>y "+y
map <Leader>p "+p

map <Leader>f :Telescope find_files<CR>
map <Leader>e :Telescope file_browser<CR>
map <Leader>b :Telescope buffers<CR>
map <Leader>t :TroubleToggle<CR>
map ? :Telescope current_buffer_fuzzy_find<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Literal navigation
nnoremap <C-left> g0
nnoremap <C-right> g$
nnoremap <C-up> gk
nnoremap <C-down> gj

" Splitter
nnoremap gs <Nop>
nnoremap <silent> gss ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
nnoremap <silent> gsip mlvip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
vnoremap <silent> gs ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>'l
