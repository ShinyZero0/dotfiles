return {

	-- LIBRARIES

	"nvim-lua/plenary.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		config = false,
		opts = {
			override = {
				["cs"] = {
					icon = "",
					color = "#95ffa4",
					name = "cs",
				},
				["xml"] = {
					icon = "",
					color = "#ffb378",
					name = "xml",
				},
			},
			override_by_extension = {
				["axaml"] = {
					icon = "",
					color = "#FFC3E1",
					name = "axaml",
				},
			},
		},
	},

	-- OTHERS

	-- {
	--  "voldikss/vim-floaterm",
	--  config = false,
	--  cmd = {
	--    "FloatermToggle",
	--  },
	--  	-- },
	{
		"dinhhuy258/vim-local-history",
		build = ":UpdateRemotePlugins",
	},
	{
		"akinsho/toggleterm.nvim",
		config = true,
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = true,
		opts = {
			user_default_options = {
				names = false,
			},
		},
		cmd = "ColorizerToggle",
	},
	-- {
	--  "m00qek/baleia.nvim",
	--  config = false,
	--  	-- },

	-- MOTIONS

	"anuvyklack/vim-smartword",
	"chaoren/vim-wordmotion",
	{
		"abecodes/tabout.nvim",
		config = true,
		opts = {
			tabkey = "<C-Space>",
			backwards_tabkey = "<C-`>",
			act_as_tab = false,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "<", close = ">" },
			},
		},
		dependencies = {},
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_transmute_enabled = 1
			vim.cmd("let g:matchup_matchpref['xml'] = {'tagnameonly': 1}")
		end,
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
	-- {
	--  "mfussenegger/nvim-treehopper",
	--  -- config = true,
	--  dependencies = {
	--    "phaazon/hop.nvim",
	--  },
	-- },
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({ useDefaultKeymaps = true })
		end,
	},

	--============= VISUAL

	{
		"lewis6991/gitsigns.nvim",
		config = true,
		dependencies = {},
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = true,
	},
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
		"zdharma-continuum/zinit-vim-syntax",
		ft = "zsh",
	},
	{
		"sam4llis/nvim-lua-gf",
		ft = "lua",
	},
	{
		"sukima/xmledit",
		ft = "xml",
		-- config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function() end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- "Fymyte/rasi.vim",
	-- "lervag/vimtex",

	-- EDITING

	"tpope/vim-surround",
	"tpope/vim-repeat",
	-- "zef/vim-cycle",
	"junegunn/vim-easy-align",
	"AndrewRadev/dsf.vim",

	-- {
	--  "jbyuki/venn.nvim",
	--  -- config = true,
	--  	-- },
	{
		"monaqa/dial.nvim",
		config = function()
			require("config.dial")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.pairs")
		end,
	},

	-- "preservim/nerdcommenter",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
		keys = {
			"gc",
		},
		event = "ModeChanged *:[vV\x16]*",
	},

	{
		"nvim-pack/nvim-spectre",
		cmd = {
			"Spectre",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- "alvan/vim-closetag",

	-- NAVIGATION

	-- {
	--  "stevearc/oil.nvim",
	--  config = true,
	--  	-- },
	{
		"mbbill/undotree",
	},
	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		-- "toppair/reach.nvim",
		"ShinyZero0/reach.nvim",
		-- dir = "~/dev/vim/reach.nvim/",
		config = true,
		cmd = "ReachOpen",
	},
	{
		"cbochs/portal.nvim",
		config = function()
			require("config.portal")
		end,
		keys = {
			"<leader>i",
			"<leader>o",
		},
	},
	-- {
	--  "simrat39/symbols-outline.nvim",
	--  config = true,
	--  	-- },
	-- {
	--  "cbochs/grapple.nvim",
	--  config = function()
	--    require("grapple").setup()
	--    vim.keymap.set("n", "<leader>M", require("grapple").toggle)
	--    vim.keymap.set("n", '<leader>"', require("grapple").popup_tags)
	--  end,
	--  cmd = {
	--    "GrapplePopup",
	--    "GrappleToggle",
	--    "GrappleCycle",
	--  },
	--  dependencies = {
	--    "nvim-lua/plenary.nvim",
	--  },
	-- },
	-- {
	-- 	"nyngwang/suave.lua",
	-- 	config = true,
	-- 		-- },
	{
		"chentoast/marks.nvim",
		config = true,
		opts = {
			mappings = {
				next = "<Leader>j",
				prev = "<Leader>k",
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			require("config.neotree")
		end,
		branch = "v2.x",
		cmd = "Neotree",
		dependencies = {
			"s1n7ax/nvim-window-picker",
			"mrbjarksen/neo-tree-diagnostics.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		config = true,
		lazy = true,
		opts = {
			selection_chars = "ASDFQW",
			fg_color = "#ffe9aa",
			other_win_hl_color = "",
		},
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

	{
		"sbdchd/neoformat",
		config = function() end,
		cmd = {
			"Neoformat",
		},
		opts = {},
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

	-- {
	--  "gelguy/wilder.nvim",
	--  config = function()
	--    require("config.wilder")
	--  end,
	--  dependencies = {
	--    {
	--      "roxma/nvim-yarp",
	--      build = { "pip install -r requirements.txt", ":UpdateRemotePlugins" },
	--    },
	--  },
	-- },
	{
		"hrsh7th/cmp-cmdline",
		config = function()
			require("config.nvim-cmp-cmd")
		end,
		event = "CmdLineEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.nvim-cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			"dcampos/cmp-snippy",
			"onsails/lspkind.nvim",
			-- {
			--   "hrsh7th/cmp-nvim-lua",
			--   cond = function()
			--     if vim.bo.filetype == "lua" then
			--       return true
			--     else
			--       return false
			--     end
			--   end
			-- },
		},
	},
	{
		"dcampos/cmp-snippy",
		event = "ModeChanged *:[vV\x16]*",
		dependencies = {
			{
				"dcampos/nvim-snippy",
				name = "snippy",
				config = true,
				dependencies = {
					"ShinyZero0/vim-snippets",
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
