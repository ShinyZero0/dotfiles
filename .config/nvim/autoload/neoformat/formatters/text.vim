function! neoformat#formatters#text#enabled() abort
    return ['Join', 'Split', "ToRus", "ToEng"]
endfunction
function! neoformat#formatters#text#Split() abort
    return {
                \ 'exe': 'sharpjoin',
                \ 'args': ['--split'],
                \ 'stdin': 0
                \ }
endfunction
function! neoformat#formatters#text#Join() abort
    return {
                \ 'exe': 'sharpjoin',
                \ 'args': ['--join'],
                \ 'stdin': 0
                \ }
endfunction
function! neoformat#formatters#text#ToEng() abort
    return {
                \ "exe": "trans",
                \ "args": ["-b", "-t", "en"],
                \ "stdin": 1
                \ }
endfunction
function! neoformat#formatters#text#ToRus() abort
    return {
                \ "exe": "trans",
                \ "args": ["-b", "-t", "ru"],
                \ "stdin": 1
                \ }
endfunction
