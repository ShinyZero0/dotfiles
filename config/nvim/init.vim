set termguicolors

let g:lf_map_keys = 0
source $HOME/.config/nvim/keys.vim
lua require('plugins')
filetype plugin indent on

set completeopt=menu,menuone,noselect
set background=dark
colorscheme challenger_deep

set ignorecase
set smartcase

let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set breakindent

set number
set noswapfile
set clipboard=unnamed
set title
set notimeout
set scrolloff=8


let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_enabled = 0
let g:vimtex_indent_enabled = 0

augroup vimtex
  autocmd!
  autocmd User VimtexEventView call b:vimtex.viewer.xdo_focus_vim()
augroup END
let g:vimtex_format_enabled = 1

let g:colorizer_colornames = 0
" autocmd BufEnter * :ColorHighlight

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
function Insert_Leave()
    let $vimlayout=system('xkb-switch -p')
    !xkb-switch -s us
endfunction
function Insert_Enter()
    if $vimlayout != ""
    !xkb-switch -s $vimlayout
    endif
endfunction
autocmd InsertLeave * silent! call Insert_Leave()
autocmd InsertEnter * silent! call Insert_Enter()
