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

	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"nvim-lua/plenary.nvim",

	-- VISUAL

	"lukas-reineke/indent-blankline.nvim",
	"tversteeg/registers.nvim",
	{
		"itchyny/lightline.vim",
		dependencies = {
			{
				"challenger-deep-theme/vim",
				pin = true,
			},
		},
	},
	-- FILETYPES

	"lervag/vimtex",
	-- "Fymyte/rasi.vim",

	-- FORMATTING

	"windwp/nvim-autopairs",
	"tpope/vim-commentary",
	"tpope/vim-surround",
	"junegunn/vim-easy-align",
	-- "alvan/vim-closetag",

	-- FILE MANAGING

	"farmergreg/vim-lastplace",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
	"lambdalisue/suda.vim",

	"easymotion/vim-easymotion",
	"voldikss/vim-floaterm",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	"KabbAmine/vCoolor.vim",
	"ziontee113/color-picker.nvim",
	"chrisbra/Colorizer",

	-- LSP

	"Hoffs/omnisharp-extended-lsp.nvim",
	"neovim/nvim-lspconfig",
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = true,
	},
	"sbdchd/neoformat",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 'junnplus/lsp-setup.nvim',
	-- "jay-babu/mason-null-ls.nvim",
	-- "jose-elias-alvarez/null-ls.nvim",
	-- "mfussenegger/nvim-lint",
	-- "mhartington/formatter.nvim",

	-- NVIM-CMP

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						version = "1.2.*",
						build = "make install_jsregexp",
						dependencies = {
							"rafamadriz/friendly-snippets",
							{
								"iurimateus/luasnip-latex-snippets.nvim",
								ft = "tex",
								config = true,
							},
						},
					},
				},
			},
		},
	},

	-- THEMES

	"folke/tokyonight.nvim",
	"NLKNguyen/papercolor-theme",
	"sjl/badwolf",
	"ray-x/aurora",
	"wuelnerdotexe/vim-enfocado",
	"savq/melange",
	"nyoom-engineering/oxocarbon.nvim",
	"EdenEast/Nightfox.nvim",
}, {
	defaults = {
		-- lazy = false
	},
})

require("config.telescope")
require("config.pairs")
require("config.nvim-cmp")
require("config.lsp")
require("config.lspsaga")
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

-- require("color-picker").setup({
-- 	["icons"] = { "ﱢ", "" },
-- })

local luasnip = require("luasnip")
luasnip.setup({})
require("luasnip-latex-snippets").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
luasnip.config.set_config({
	store_selection_keys = "<Tab>",
	update_events = "TextChanged",
	"TextChangedI",
})
