set shell=/usr/bin/bash

set ignorecase
set title
set noswapfile
set undofile

set termguicolors
set number
set cursorline
set noshowmode

set tabstop=4 shiftwidth=4 expandtab
set scrolloff=5
set breakindent

set timeoutlen=3000

filetype plugin indent on

set conceallevel=0
let g:vim_json_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

let g:EasyMotion_smartcase = 1

function! SourceIfExists(file)
    if filereadable(expand(a:file))
       exe "source " a:file
   endif
endfunction

" call SourceIfExists("$HOME/.config/nvim/init-mobile.vim")
" call SourceIfExists("$HOME/.config/nvim/init-desktop.vim")
lua require("config.lazy")
source $HOME/.config/nvim/init-alt.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/keys.vim
source $HOME/.config/nvim/colors.vim

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.axaml"
let g:closetag_filetypes = "html,xhtml,phtml,xml"

command Reinit source $HOME/.config/nvim/init.vim
