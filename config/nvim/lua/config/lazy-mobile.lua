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

    "tversteeg/registers.nvim",
    "easymotion/vim-easymotion",
    "voldikss/vim-floaterm",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" } ,
    "nvim-telescope/telescope-file-browser.nvim",
    "junegunn/vim-easy-align",
    "tpope/vim-surround" ,
    "tpope/vim-commentary",
    "kyazdani42/nvim-web-devicons",
    "itchyny/lightline.vim",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "windwp/nvim-autopairs",
    "chrisbra/Colorizer",
    -- LSP
    -- "neovim/nvim-lspconfig" ,
    -- {
    --     "glepnir/lspsaga.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("lspsaga").setup({})
    --     end,
    -- },
    -- "mfussenegger/nvim-lint",
    -- 'williamboman/mason.nvim',
    -- 'williamboman/mason-lspconfig.nvim',
    -- { "lervag/vimtex"},

    -- SNIPPETS
    { "L3MON4D3/LuaSnip", version = "<CurrentMajor>.*" },
    "rafamadriz/friendly-snippets",

    -- THEMES
    "ray-x/aurora",
    "wuelnerdotexe/vim-enfocado",
    {
        "challenger-deep-theme/vim",
        pin = true
    },
    "savq/melange",
    "nyoom-engineering/oxocarbon.nvim",
    "EdenEast/Nightfox.nvim",

    -- 'junnplus/lsp-setup.nvim',
},
{
    defaults = {
    },
})

require("config.telescope")
require("config.pairs")
require("config.registers")
require("config.treesitter")
require("config.blankline")

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
