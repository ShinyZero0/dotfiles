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

cnoremap <C-left>  <S-left>
cnoremap <C-right> <S-right>
cnoremap <C-BS> <C-w>
cnoreabbrev m +1mark z \| move

" INSERT MODE 

" inoremap <C-left>  <cmd>normal bi<CR>
" inoremap <C-right> <cmd>normal ea<CR>

" VISUAL MODE

" vnoremap p "_d "='v:register'P
xnoremap & :'<,'>&<CR>

" MISC PLUGINS

" nnoremap <F5> <cmd>ToggleTerm direction=vertical size=70<CR>
" nnoremap <Leader>x <cmd>ToggleTermSendCurrentLine<CR>
" vnoremap <Leader>x <cmd>ToggleTermSendVisualLines<CR>
" nnoremap <F5> <cmd>FloatermToggle<CR>
tmap <C-q> <C-\><C-n><C-q>
tmap <F5> <C-q>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nmap <C-Tab> <Plug>(snippy-cut-text)
xmap <C-Tab> <Plug>(snippy-cut-text)

map ? <cmd>HopPatternMW<CR>
map <C-w> <cmd>HopWordMW<CR>
map K <cmd>HopVertical<CR>
map <C-f> <cmd>HopChar1<CR>

" map <Leader>l <cmd>GrappleCycle forward<CR>
" map <Leader>h <cmd>GrappleCycle backward<CR>

" nnoremap <C-h> :HunkLineToggle<CR>

nnoremap <Leader>t <cmd>Neotree focus reveal<CR>

nnoremap <Leader>f <cmd>Telescope find_files<CR>
nnoremap <Leader>r <cmd>Telescope resume<CR>
nnoremap <Leader>' <cmd>Telescope marks<CR>

" LITERAL NAVIGATION

nnoremap <C-left>  g0
nnoremap <C-right> g$
nnoremap k  gk
nnoremap j  gj

" 0 TO FIRST WORD

nnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
xnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
onoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'

" I and A to right indent

nnoremap <expr> I getline('.') =~ '^\s*$' ? 'S' : 'I'
nnoremap <expr> A getline('.') =~ '^\s*$' ? 'S' : 'A'

map <C-q> <cmd>lua CoolExitFunc()<CR>
" xmap <leader>c <cmd>lua ToggleMostComments(vim.fn.visualmode())<CR>

" nnoremap g1 1gt
" nnoremap g2 2gt
" nnoremap g3 3gt
" nnoremap g4 4gt
" nnoremap g5 5gt
" nnoremap g6 6gt
" nnoremap g7 7gt
" nnoremap g8 8gt
" nnoremap g9 9gt

" map <Leader>// :Telescope<CR>
" map <Leader>/h :Telescope heading<CR>
" map <Leader>/g :Telescope live_grep<CR>
" map <Leader>/h :Telescope help_tags<CR>

" map <Leader>e :Telescope file_browser<CR>
" map <Leader>b :Telescope buffers<CR>
" map <Leader>t :NeoTreeFloatToggle<CR>

" map ? :Telescope current_buffer_fuzzy_find<CR>

