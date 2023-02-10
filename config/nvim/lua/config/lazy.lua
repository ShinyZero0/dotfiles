local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup({

    "easymotion/vim-easymotion",
    "Hoffs/omnisharp-extended-lsp.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "dag/vim-fish",
    "voldikss/vim-floaterm",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" } ,
    "Fymyte/rasi.vim" ,
    "tpope/vim-surround" ,
    "junegunn/vim-easy-align",
    "Yggdroot/indentLine",
    "tpope/vim-commentary",
    "kyazdani42/nvim-web-devicons",
    "lambdalisue/suda.vim",
    "itchyny/lightline.vim",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "windwp/nvim-autopairs",
    "KabbAmine/vCoolor.vim",
    { "ziontee113/color-picker.nvim"},
    "chrisbra/Colorizer",
    -- LSP
    "neovim/nvim-lspconfig" ,
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        config = function()
            require("lspsaga").setup({})
        end,
    },
    "mfussenegger/nvim-lint",
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    { "lervag/vimtex"},

    -- NVIM-CMP
    {
        "hrsh7th/nvim-cmp" ,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline" ,
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-omni" ,
        },
    },

    -- SNIPPETS
    { "L3MON4D3/LuaSnip", version = "<CurrentMajor>.*" },
    "rafamadriz/friendly-snippets",
    {
        "iurimateus/luasnip-latex-snippets.nvim", 
        ft = "tex", 
        config = function()
        end,
    },

    -- THEMES
    "sjl/badwolf",
    "ray-x/aurora",
    "wuelnerdotexe/vim-enfocado",
    "challenger-deep-theme/vim",
    "savq/melange",
    "nyoom-engineering/oxocarbon.nvim",
    "EdenEast/Nightfox.nvim",

    -- 'junnplus/lsp-setup.nvim',
},
{
    defaults = {
    },
})

require('config.telescope')
require('config.nvim-cmp')
require('config.lsp')

require("config.pairs")

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = true,
})

local luasnip = require("luasnip")

require("color-picker").setup {
    ["icons"] = { "ﱢ", "" },
}

-- require('lualine').setup {
--     options = { theme = 'challenger_deep' }
-- }
require("luasnip-latex-snippets").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

luasnip.config.set_config({
  store_selection_keys = "<Tab>",
})
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "help" },
    auto_install = true,
    ignore_install = { "latex" },
    highlight = {
        enable = true,
        disable = { "latex" },
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
