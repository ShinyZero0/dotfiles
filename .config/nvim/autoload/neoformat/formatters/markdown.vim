function! neoformat#formatters#markdown#enabled() abort
	return ['Join', 'Split', "ToRus", "ToEng", "Typograf", "comrak"]
endfunction
function! neoformat#formatters#markdown#Split() abort
	return {
				\ 'exe': 'sentsplit',
				\ 'args': ['--split'],
				\ 'stdin': 0
				\ }
endfunction
function! neoformat#formatters#markdown#Join() abort
	return {
				\ 'exe': 'sentsplit',
				\ 'args': ['--join'],
				\ 'stdin': 0
				\ }
endfunction
function! neoformat#formatters#markdown#ToEng() abort
	return {
				\ "exe": "trans",
				\ "args": ["-b", "-t", "en"],
				\ "stdin": 1
				\ }
endfunction
function! neoformat#formatters#markdown#ToRus() abort
	return {
				\ "exe": "trans",
				\ "args": ["-b", "-t", "ru"],
				\ "stdin": 1
				\ }
endfunction
function! neoformat#formatters#markdown#Typograf() abort
	return {
				\ "exe": "npx",
				\ "args": ["typograf-cli", "--stdin"],
				\ "stdin": 1
				\ }
endfunction
function! neoformat#formatters#markdown#comrak() abort
	return {
				\ "exe": "comrak",
				\ "args": ["-t", "commonmark"],
				\ "stdin": 1
				\ }
endfunction
