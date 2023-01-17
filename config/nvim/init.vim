set termguicolors
lua require('plugins')

set completeopt=menu,menuone,noselect
source $HOME/.config/nvim/keys.vim
set background=dark
set scrolloff=8
set ignorecase
set smartcase

filetype plugin indent on
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

set tabstop=8
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

set number
set noswapfile
set clipboard=unnamed

colorscheme challenger_deep
let g:colorizer_colornames = 0
" let g:colorizer_auto_color = 1
" let g:colorizer_disable_bufleave = 1
" let g:coq_settings = { 'auto_start': 'shut-up' }
autocmd BufEnter * :ColorHighlight

" Show relative numbers
" in visual mode only
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
