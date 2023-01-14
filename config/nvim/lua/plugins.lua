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
    "voldikss/vim-floaterm",
    "ptzz/lf.vim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" } ,
    "Fymyte/rasi.vim" ,
    "neovim/nvim-lspconfig" ,
    "hrsh7th/cmp-vsnip" ,
    'hrsh7th/vim-vsnip' ,
    "hrsh7th/cmp-nvim-lsp" ,
    "hrsh7th/cmp-buffer" ,
    "hrsh7th/cmp-path" ,
    "hrsh7th/cmp-cmdline" ,
    "hrsh7th/nvim-cmp" ,
    "tpope/vim-surround" ,
    "junegunn/vim-easy-align",
    { "ms-jpq/chadtree", build = "python3 -m chadtree deps" },
    "Yggdroot/indentLine",
    "tpope/vim-commentary",
    "kyazdani42/nvim-web-devicons",
    "lambdalisue/suda.vim",
    "nvim-lualine/lualine.nvim",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "jiangmiao/auto-pairs",
    "KabbAmine/vCoolor.vim",
    { "ziontee113/color-picker.nvim"},
    "chrisbra/Colorizer",
    "neovim/nvim-lspconfig",
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- "norcalli/nvim-colorizer.lua",
    -- { "ms-jpq/coq_nvim", branch = "coq" },
    -- { "ms-jpq/coq.artifacts", branch = "artifacts" },
    -- 'junnplus/lsp-setup.nvim',
    
    --Themes
    "sjl/badwolf",
    "ray-x/aurora",
    "wuelnerdotexe/vim-enfocado",
    "challenger-deep-theme/vim",
    "savq/melange",
    "nyoom-engineering/oxocarbon.nvim",
    "EdenEast/Nightfox.nvim",
})

require("color-picker").setup {
    ["icons"] = { "ﱢ", "" },
}
require('lualine').setup {
    options = { theme = 'challenger_deep' }
}

require("mason").setup()
require("mason-lspconfig").setup()
local cmp = require'cmp'
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({

    snippet = {
        expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
            cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
            cmp.complete()
            else
            fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping( function()
            if cmp.visible() then
            cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" } ),

        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),

    }),

    sources = cmp.config.sources({
        { name ='nvim_lsp' },
    }, {
        {name = 'buffer'},
    })
})
require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
}
-- require('lsp-setup').setup({
--     servers = {
--         pylsp = {}
--     }
-- })
-- COMPLETION
