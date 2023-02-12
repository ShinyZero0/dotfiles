set ignorecase
set smartcase
set nocompatible
set noswapfile
set termguicolors
set title

set number
set cursorline
set cursorcolumn

set tabstop=4 shiftwidth=4 expandtab
set scrolloff=5
set notimeout
set breakindent

let g:vim_json_conceal=0

filetype plugin indent on

source $HOME/.config/nvim/mobile.vim
source $HOME/.config/nvim/keys.vim

colorscheme challenger_deep
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.axaml'

lua << EOF

require("config.mind")
require("config.treesitter")
require("config.pairs")

local function on_attach(client)
  print('Attached to ' .. client.name)
end

EOF

command Reinit source $HOME/.config/nvim/init.vim
