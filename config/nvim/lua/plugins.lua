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
    "nvim-telescope/telescope-file-browser.nvim",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "dag/vim-fish",
    { "ptzz/lf.vim" },
    "voldikss/vim-floaterm",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x" } ,
    "Fymyte/rasi.vim" ,
    "neovim/nvim-lspconfig" ,
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
    { "lervag/vimtex", lazy=false },

    -- NVIM-CMP
    "hrsh7th/cmp-nvim-lsp" ,
    "hrsh7th/cmp-buffer" ,
    "hrsh7th/cmp-path" ,
    "hrsh7th/cmp-cmdline" ,
    "hrsh7th/nvim-cmp" ,
    "saadparwaiz1/cmp_luasnip",

    -- SNIPPETS
    { "L3MON4D3/LuaSnip", version = "<CurrentMajor>.*" },
    "rafamadriz/friendly-snippets",
    {
        "iurimateus/luasnip-latex-snippets.nvim", 
        ft = "tex", 
        config = function()
            require'luasnip-latex-snippets'.setup()
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
})
require("color-picker").setup {
    ["icons"] = { "ﱢ", "" },
}
require('lualine').setup {
    options = { theme = 'challenger_deep' }
}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})
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
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
		require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
            cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            elseif has_words_before() then
            cmp.complete()
            else
            fallback()
            end
            end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
            cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
            else
            fallback()
            end
        end, { "i", "s" }),
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),

    }),

    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'omni' },
        { name = 'buffer' },
    })
})
require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
}
require'nvim-treesitter.configs'.setup {
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

local actions = require("telescope.actions")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
require("telescope").load_extension "file_browser"
-- require('lsp-setup').setup({
--     servers = {
--         pylsp = {}
--     }
-- })
-- COMPLETION
