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
	"nvim-lua/plenary.nvim",

  -- MOTIONS

  "anuvyklack/hydra.nvim",
  "anuvyklack/vim-smartword",
  "chaoren/vim-wordmotion",
  {
    "phaazon/hop.nvim",
    config = true,
  },

	-- VISUAL

	"lukas-reineke/indent-blankline.nvim",
  "folke/which-key.nvim",
  {
    "folke/which-key.nvim",
    dependencies = {
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('config.lualine')
    end,
    dependencies = {
      "ShinyZero0/challenger-deep.nvim"
    }
  },

	-- FILETYPES

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- "Fymyte/rasi.vim",
	-- "lervag/vimtex",

	-- EDITING

  {
    "windwp/nvim-autopairs",
    config = function ()
      require('config.pairs')
    end,
    dependencies = {
    }
  },
	"tpope/vim-commentary",
	"kylechui/nvim-surround",
	"junegunn/vim-easy-align",
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
  },
	"zef/vim-cycle",

	-- "monaqa/dial.nvim",
	-- "alvan/vim-closetag",

	-- FILE MANAGING

	"farmergreg/vim-lastplace",
	"lambdalisue/suda.vim",
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
			"crispgm/telescope-heading.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},

	"voldikss/vim-floaterm",

	"KabbAmine/vCoolor.vim",
	"ziontee113/color-picker.nvim",
	"chrisbra/Colorizer",

	-- LSP

	"Hoffs/omnisharp-extended-lsp.nvim",
	"neovim/nvim-lspconfig",
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
	},
	"sbdchd/neoformat",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- {
	--     "ray-x/lsp_signature.nvim",
	--     config = true,
	-- },
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
				"dcampos/cmp-snippy",
				dependencies = {
					{
						"dcampos/nvim-snippy",
						dependencies = {
							"honza/vim-snippets",
						},
					},
				},
			},
		},
	},

	-- THEMES

  {
    "ShinyZero0/challenger-deep.nvim",
    lazy = false,
  },
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"NLKNguyen/papercolor-theme",
		lazy = true,
	},
	{
		"sjl/badwolf",
		lazy = true,
	},
	{
		"ray-x/aurora",
		lazy = true,
	},
	{
		"wuelnerdotexe/vim-enfocado",
		lazy = true,
	},
	{
		"savq/melange",
		lazy = true,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = true,
	},
	{
		"EdenEast/Nightfox.nvim",
    lazy = true,
  },
},
{
  ui = {
    border = "rounded",
  },
  defaults = {
    -- lazy = false
  }
}
)


-- require("config.pairs")
require("config.nvim-cmp")
require("config.lsp")
require("config.lspsaga")

require("config.telescope")
require('config.neotree')

require("config.treesitter")
require("config.blankline")

require("config.hydra")

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})

require("snippy").setup({})
require('which-key').setup({
  window = {
    border = "rounded"
  },
  triggers_blacklist = {
    c = {"s/", "s"}
  }

})

-- require("color-picker").setup({
-- 	["icons"] = { "ﱢ", "" },
-- })

-- vim:ts=2:sw=2
