function! neoformat#formatters#json#enabled() abort
    return [ 'nujson' ]
endfunction
function! neoformat#formatters#json#nujson() abort
    return {
                \ 'exe': 'nujson',
                \ 'stdin': 0
                \ }
endfunction
