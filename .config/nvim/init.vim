set ignorecase
set title
set noswapfile
set undofile

set splitright
set splitbelow

" VISUAL
set termguicolors
set number
set cursorline
set noshowmode
set cmdheight=0
set showtabline=0
set conceallevel=0

set tabstop=4 shiftwidth=4 expandtab
set scrolloff=5
set breakindent

set whichwrap+=h,l,<,>,[,]
set formatoptions=1,j,tc

set completeopt=noselect
" ,menuone
set pumheight=10

set spelllang=en,ru
set timeoutlen=5000

filetype plugin indent on

" wrap num
"
" augroup showbreak
"     autocmd!
"     autocmd BufRead * call AdjustShowBreak()
" augroup END
"
" function! AdjustShowBreak()
"     let real_numberwidth = strlen(line('$'))
"     let &showbreak = repeat("\ ", max([&nuw, real_numberwidth]))
" endfunction
"
" highlight Underline cterm=underline
"
" augroup showbreak
"     autocmd!
"     autocmd VimEnter * call <SID>ShowBreakInit()
"     autocmd CursorMoved,CursorMovedI,CursorHold * call <SID>ShowBreak()
" augroup END
"
"
" let s:showbreak_matches = []
" function! s:ShowBreak()
"     " delete old matches
"     for l:match in s:showbreak_matches
"         silent! call matchdelete(l:match)
"     endfor
"
"     let win_width = winwidth("%")
"     let line_length = virtcol([line('.'), '$']) - 1
"     if line_length > s:showbreak_longest
"         let s:showbreak_longest = line_length
"     endif
"
"     if s:showbreak_longest > win_width
"         " match first column in each wrapped line
"         for l:col in range(win_width+1, s:showbreak_longest, win_width)
"             call add(s:showbreak_matches, matchadd("Underline", '\%'.l:col.'v'))
"         endfor
"     endif
" endfunction
"
" function s:ShowBreakInit()
"     let s:showbreak_longest = max(map(range(1, line('$')), "virtcol([v:val, '$'])-1"))
"     call <SID>ShowBreak()
" endfunction

let g:vim_json_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

let g:EasyMotion_smartcase = 1
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
let g:neoformat_enabled_python = ["black", "autopep8", "yapf"]
let g:neoformat_enabled_cs = ["csharpier", "uncrustify", "clangformat"]

function! SourceIfExists(file)
    if filereadable(expand(a:file))
       exe "source " a:file
   endif
endfunction

source $HOME/.config/nvim/functions.vim
lua require("functions")
lua require("config.lazy")
source $HOME/.config/nvim/init-alt.vim
source $HOME/.config/nvim/keys.vim
call SourceIfExists("$HOME/.config/nvim/keys-alt.vim")
source $HOME/.config/nvim/colors.vim

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.axaml"
let g:closetag_filetypes = "html,xhtml,phtml,xml"

highlight IndentBlanklineIndent1 guifg=#906cff gui=nocombine
highlight IndentBlanklineIndent2 guifg=#65b2ff gui=nocombine
" highlight IndentBlanklineIndent3 guifg=#62d196 gui=nocombine

command Reinit source $HOME/.config/nvim/init.vim
