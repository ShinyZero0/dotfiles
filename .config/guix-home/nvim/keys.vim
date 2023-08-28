" COMMAND LINE

cnoreabbrev pl lua print
cnoreabbrev m +1mark z \| move
cnoreabbrev h vertical help
command TSFold setlocal foldexpr=nvim_treesitter#foldexpr() | setlocal foldmethod=expr
