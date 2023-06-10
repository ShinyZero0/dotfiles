" let mapleader=" "
nnoremap <buffer> gd :lua require('omnisharp_extended').lsp_definitions()<cr>

let g:neoformat_cs_uncrustify = {
			\ 'exe': 'uncrustify',
			\ 'stdin': 1,
			\ 'args': [ '-l=CS', '-c', '~/.config/uncrustify' ],
\ }
let g:neoformat_cs_clangformat = {
			\ 'exe': 'clang-format',
			\ 'stdin': 1,
			\ 'args': ['--style=Microsoft', '--assume-filename=.cs'],
\ }
let g:neoformat_cpp_clangformat = {
			\ 'exe': 'clang-format',
			\ 'stdin': 1,
			\ 'args': ['--style=Microsoft', '--assume-filename=.cpp'],
\ }
let g:neoformat_enabled_cs = ["csharpier", "uncrustify", "clangformat"]
