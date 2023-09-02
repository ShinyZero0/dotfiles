function! neoformat#formatters#json#enabled() abort
	return ["jsonfmt"]
endfunction

function! neoformat#formatters#json#jsonfmt() abort
	return {
				\ 'exe': 'jsonfmt',
				\ 'args': [],
				\ 'stdin': 0
				\ }
endfunction
