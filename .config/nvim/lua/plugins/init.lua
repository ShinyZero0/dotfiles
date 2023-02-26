return {

	-- LIBRARIES

	"nvim-lua/plenary.nvim",

	-- OTHERS

	"voldikss/vim-floaterm",

	"ziontee113/color-picker.nvim",
	"chrisbra/Colorizer",

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
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
		dependencies = {
			"ShinyZero0/challenger-deep.nvim",
		},
	},

	-- FILETYPES

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- "Fymyte/rasi.vim",
	-- "lervag/vimtex",

	-- EDITING

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.pairs")
		end,
		dependencies = {},
	},
	{
		"numToStr/Comment.nvim",
		config = true,
		keys = {
			"gc",
		},
    event = "ModeChanged *:[vV\x16]*"
	},
	{
		"kylechui/nvim-surround",
		config = true,
		opts = {},
		dependencies = {},
	},
	"junegunn/vim-easy-align",
	{
		"nvim-pack/nvim-spectre",
		keys = {
			"<Leader>s",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"zef/vim-cycle",

	-- "monaqa/dial.nvim",
	-- "alvan/vim-closetag",

	-- FILE MANAGING

	"farmergreg/vim-lastplace",
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			require("config.neotree")
		end,
		branch = "v2.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		init = function() -- init is called on startup. i.e. no lazy.
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() >= 1 then
				vim.api.nvim_create_autocmd("UIEnter", {
					once = true,
					callback = function(_)
						for i = 0, vim.fn.argc() - 1 do -- check for all command line arguments
							local stat = vim.loop.fs_stat(vim.fn.argv(i))
							if stat and stat.type == "directory" then -- only if any of them is a dir
								require("neo-tree") -- require neo-tree, which asks lazy to load neo-tree which calls setup with `opts` and
								-- since hijack_netrw_behavior is set there, neo-tree overwrites netrw on setup
								return
							end
						end
					end,
				})
			end
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"crispgm/telescope-heading.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},
	},

	-- LSP & CO

	"sbdchd/neoformat",
	-- {
	--     "ray-x/lsp_signature.nvim",
	--     config = true,
	-- },
	-- 'junnplus/lsp-setup.nvim',
	-- "jay-babu/mason-null-ls.nvim",
	-- "jose-elias-alvarez/null-ls.nvim",
	-- "mfussenegger/nvim-lint",
	-- "mhartington/formatter.nvim",

	-- COMPLETION and SNIPPETS

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.nvim-cmp")
		end,
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
						name = "snippy",
						config = true,
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
}
-- vim:ts=2:sw=2