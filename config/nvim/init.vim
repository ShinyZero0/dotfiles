set clipboard=unnamedplus
set number
set ignorecase
set smartcase
set nocompatible
set hidden
set noswapfile
set tabstop=4 shiftwidth=4 expandtab
set termguicolors
set cursorline
set cursorcolumn
set so=5
set notimeout
set title
set breakindent

filetype plugin indent on

call plug#begin()
Plug 'alvan/vim-closetag',
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*', 'do': 'make install_jsregexp'},
Plug 'ggandor/leap.nvim',
Plug 'phaazon/mind.nvim',
Plug 'tpope/vim-repeat',
Plug 'tpope/vim-surround',
Plug 'junegunn/vim-easy-align',
Plug 'tpope/vim-commentary',
Plug 'Yggdroot/indentLine',
Plug 'kyazdani42/nvim-web-devicons',
Plug 'folke/trouble.nvim',
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'windwp/nvim-autopairs',
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'davidhalter/jedi-vim' 
" Plug 'deoplete-plugins/deoplete-jedi'
Plug 'ervandew/supertab'
Plug 'neovim/nvim-lspconfig'
Plug 'creativenull/diagnosticls-configs-nvim', { 'tag': 'v0.1.8' }
" Themes
Plug 'ray-x/aurora'
Plug 'nanotech/jellybeans.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Plug 'python-rope/ropevim'
call plug#end()

colorscheme challenger_deep
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.axaml'

lua << EOF
local modules = {
    "cfgplug.mind",
    }
for i, item in ipairs(modules) do
    require(item)
end

-- require('leap').add_default_mappings()
-- local dlsconfig = require 'diagnosticls-configs'
-- local pylint = require 'diagnosticls-configs.linters.pylint'
-- dlsconfig.init {
--   default_config = true,
--   on_attach = on_attach,
-- }
-- dlsconfig.setup {
-- 		['python'] = {
-- 				linter = pylint
-- 		}
-- }
require('nvim-autopairs').setup{}
-- require('lspconfig').pylsp.setup{}
require('trouble').setup{}
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "help" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,

        disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then

            return true
            end
            end,

            additional_vim_regex_highlighting = false,
            },
}

EOF

nnoremap <C-b> <cmd>TroubleToggle<cr>
nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap <Leader>s <Plug>(leap-forward-to)
nnoremap <C-left> g0
nnoremap <C-right> g$
nnoremap <C-up> gk
nnoremap <C-down> gj
nnoremap gs <Nop>
nnoremap <silent> gss ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l
nnoremap <silent> gsip mlvip:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l
vnoremap <silent> gs ml:s/\([\.?!]\) \([А-ЯA-Z]\)/\1\r\2/ge<CR>'l
command Reinit source $HOME/.config/nvim/init.vim
