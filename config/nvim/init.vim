set shell=/usr/bin/bash

set ignorecase
set noswapfile
set termguicolors
set title
set undofile

set number
set cursorline
set noshowmode

set tabstop=4 shiftwidth=4 expandtab
set scrolloff=5
set notimeout
set breakindent

filetype plugin indent on

set conceallevel=0
let g:vim_json_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

let g:EasyMotion_smartcase = 1

source $HOME/.config/nvim/init-mobile.vim
source $HOME/.config/nvim/init-desktop.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/keys.vim
source $HOME/.config/nvim/colors.vim

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.axaml"
let g:closetag_filetypes = "html,xhtml,phtml,xml"

command Reinit source $HOME/.config/nvim/init.vim
