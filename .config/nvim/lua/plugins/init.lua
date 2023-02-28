return {

	-- LIBRARIES

	"nvim-lua/plenary.nvim",

	-- OTHERS

	"voldikss/vim-floaterm",

	{
		"NvChad/nvim-colorizer.lua",
		config = true,
		opts = {
			user_default_options = {
				names = false,
			},
		},
		dependencies = {},
	},

	-- MOTIONS

	"anuvyklack/vim-smartword",
	"chaoren/vim-wordmotion",
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, {})
			vim.keymap.set("n", "<leader>'", require("harpoon.ui").toggle_quick_menu, {})
		end,
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- {
	-- 	"cbochs/grapple.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },
	{
		"cbochs/portal.nvim",
		config = function()
			require("portal").setup(opts)
			vim.keymap.set("n", "<leader>o", require("portal").jump_backward, {})
			vim.keymap.set("n", "<leader>i", require("portal").jump_forward, {})
		end,
		opts = {
			portal = {
				body = {
					options = {
						relative = "editor",
					},
				},
				title = {
					options = {
						relative = "editor",
					},
				},
			},
		},
		dependencies = {},
	},
	{
		"anuvyklack/hydra.nvim",
		config = function()
			require("config.hydra")
		end,
	},
	{
		"phaazon/hop.nvim",
		config = true,
	},

	-- VISUAL

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.blankline")
		end,
	},
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

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
	},
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
		event = "ModeChanged *:[vV\x16]*",
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
		-- cmd = "Neotree",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		init = function() 
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() >= 1 then
				vim.api.nvim_create_autocmd("UIEnter", {
					once = true,
					callback = function(_)
						for i = 0, vim.fn.argc() - 1 do 
							local stat = vim.loop.fs_stat(vim.fn.argv(i))
							if stat and stat.type == "directory" then 
								require("neo-tree") 
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
		config = function()
			require("config.telescope")
		end,
		cmd = {
			"Telescope",
		},
		branch = "0.1.x",
		dependencies = {
			"crispgm/telescope-heading.nvim",
			-- "nvim-telescope/telescope-file-browser.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},
	},

	-- LSP & CO

	{
		"sbdchd/neoformat",
		config = function() end,
		cmd = {
			"Neoformat",
		},
		opts = {},
		dependencies = {},
	},
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
