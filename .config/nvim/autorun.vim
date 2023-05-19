autocmd BufEnter * set formatoptions=1jtc

fun FoldUsings()
	syn region FoldUsings start=/^using.*$/ end=/^$/ fold
	syn sync fromstart
	set foldmethod=syntax
endf

autocmd BufEnter *.cs call FoldUsings()
autocmd BufEnter *.axaml,*.xaml setlocal ft=xml ts=2 sw=2

autocmd BufWritePre *.lua Neoformat
autocmd BufNewFile * silent! !mkdir -p $(dirname %)

" fun! RetabHard()
"	set noet
"	mark z
"	silent! %s/\(^\s*\)\@<=	   /\t/g
"	'z
" endf
fun! RetabSoft()
	set et
	retab!
endf
autocmd BufWritePre *.md call RetabSoft()

au BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

" call MainFile()
