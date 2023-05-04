autocmd BufEnter * set formatoptions=1jtc

autocmd BufEnter *.cs call FoldUsings()
autocmd BufEnter *.axaml,*.xaml setlocal ft=xml ts=2 sw=2

autocmd BufWritePre *.lua Neoformat

" fun! RetabHard()
" 	set noet
" 	mark z
" 	silent! %s/\(^\s*\)\@<=    /\t/g
" 	'z
" endf
fun! RetabSoft()
	set et
	retab!
endf
autocmd BufEnter,BufWritePre *.md,*.txt call RetabSoft()

au LspAttach * call RemapGotoDefinition()

au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

" call MainFile()
