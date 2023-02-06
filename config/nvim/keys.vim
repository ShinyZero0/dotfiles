nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = "\\"
map ; :
map <C-s> :w<CR>
map <C-q> :q<CR>
map <Leader>y "+y
map <Leader>p "+p
map <Leader>l :LfCurrentFileExistingOrNewTab<CR>
map <Leader>f :Telescope file_browser<CR>
map <Leader>b :Telescope buffers<CR>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap <C-left> g0
nnoremap <C-right> g$
nnoremap <C-up> gk
nnoremap <C-down> gj
nnoremap gs <Nop>
nnoremap <silent> gss :s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>
nnoremap <silent> gsip vip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>
vnoremap <silent> gs :s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge\|:'[,']normal ==<CR>:noh<CR>
