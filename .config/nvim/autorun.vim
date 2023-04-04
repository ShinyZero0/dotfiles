autocmd BufEnter * set formatoptions=1jtc 

autocmd BufEnter *.cs call FoldUsings()
autocmd BufEnter *.axaml,*.xaml setlocal ft=xml ts=2 sw=2

autocmd BufWritePre *.lua Neoformat
au LspAttach * call RemapGotoDefinition()

au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

" call MainFile()
