set ignorecase
set smartcase
set nocompatible
set noswapfile
set termguicolors
set title

set number
set cursorline

set tabstop=4 shiftwidth=4 expandtab
set scrolloff=5
set notimeout
set breakindent

let g:vim_json_conceal=0

filetype plugin indent on
let g:lightline = {'colorscheme': 'challenger_deep'}

source $HOME/.config/nvim/init-mobile.vim
source $HOME/.config/nvim/init-desktop.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/keys.vim

colorscheme challenger_deep
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.axaml'

command Reinit source $HOME/.config/nvim/init.vim
