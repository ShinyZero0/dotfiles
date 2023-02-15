set clipboard+=unnamed
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

" NEEDED FOR NVIM-CMP
set completeopt=menu,menuone,noselect
autocmd BufEnter *.axaml,*.xaml set ft=xml


lua require("config.lazy-desktop")
