set termguicolors
let g:lightline = { 'colorscheme': 'challenger_deep'}

source $HOME/.config/nvim/keys.vim
lua require("config.lazy")
filetype plugin indent on

set completeopt=menu,menuone,noselect
set background=dark

colorscheme challenger_deep
hi link lualine_b_diagnostics_hint_normal   lualine_a_normal
hi link lualine_b_diagnostics_info_terminal lualine_a_normal
hi link lualine_b_diff_added_normal         lualine_a_normal
hi link lualine_b_diff_added_command        lualine_a_normal


set ignorecase
set smartcase

let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

set tabstop=4
set shiftwidth=4
set expandtab

set breakindent

set number
set noswapfile
set clipboard=unnamed
set title
set notimeout
set scrolloff=8
set cursorline

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_enabled = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_syntax_conceal_disable = 1

let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
hi link EasyMotionTarget String

autocmd BufEnter *.axaml,*.xaml set ft=xml

augroup vimtex
  autocmd!
  autocmd User VimtexEventView call b:vimtex.viewer.xdo_focus_vim()
augroup END
let g:vimtex_format_enabled = 1

let g:colorizer_colornames = 0
" autocmd BufEnter * :ColorHighlight

command Reinit source $HOME/.config/nvim/init.vim
