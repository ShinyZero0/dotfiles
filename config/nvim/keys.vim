
nnoremap <SPACE> <Nop>
let mapleader = " "

nnoremap <Leader>s <Plug>(leap-forward-to)
nnoremap <C-left> g0
nnoremap <C-right> g$
nnoremap <C-up> gk
nnoremap <C-down> gj
nnoremap <silent> gs <Nop>
nnoremap <silent> gss ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l
nnoremap <silent> gsip mlvip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l
vnoremap <silent> gs ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l

cnoremap <C-v> <C-r>"
inoremap <C-v> <Esc>pa
