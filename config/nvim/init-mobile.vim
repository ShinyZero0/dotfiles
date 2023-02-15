set clipboard-=unnamed

" call plug#begin()
" Plug 'alvan/vim-closetag',
" Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*', 'do': 'make install_jsregexp'},
" Plug 'ggandor/leap.nvim',
" Plug 'phaazon/mind.nvim',
" Plug 'tpope/vim-repeat',
" Plug 'tpope/vim-surround',
" Plug 'junegunn/vim-easy-align',
" Plug 'tpope/vim-commentary',
" Plug 'lukas-reineke/indent-blankline.nvim'
" " Plug 'Yggdroot/indentLine',
" Plug 'kyazdani42/nvim-web-devicons',
" Plug 'nvim-lua/plenary.nvim',
" Plug 'windwp/nvim-autopairs',
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'ervandew/supertab'
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Plug 'nvim-telescope/telescope-file-browser.nvim'

" " Themes
" Plug 'ray-x/aurora'
" Plug 'nanotech/jellybeans.vim'
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" call plug#end()

lua require("config.lazy-mobile")
