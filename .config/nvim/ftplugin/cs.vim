" let mapleader=" "
nnoremap <buffer> gd :vsplit\|lua require('omnisharp_extended').lsp_definitions()<cr>
