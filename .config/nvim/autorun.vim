autocmd BufEnter * set formatoptions=1jtc
fun! IndentPlugins()
	setlocal fdl=2
	normal zx
endf
autocmd BufEnter */.config/nvim/lua/plugins/* call IndentPlugins()

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
autocmd BufEnter,BufWritePre *.md call RetabSoft()

au LspAttach * call RemapGotoDefinition()

au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

" call MainFile()
