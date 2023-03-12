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
		dependencies = {},
	},

	-- OTHERS

	{
		"voldikss/vim-floaterm",
		config = false,
		cmd = {
			"FloatermToggle",
		},
		dependencies = {},
	},

	-- {
	--  "m00qek/baleia.nvim",
	--  config = false,
	--  dependencies = {},
	-- },
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
    "andymass/vim-matchup",
    config = function ()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_transmute_enabled = 1
      vim.cmd("let g:matchup_matchpref['xml'] = {'tagnameonly': 1}")
    end,
    dependencies = {},
  },
	-- {
	-- 	"chrisgrieser/nvim-various-textobjs",
	-- 	config = function()
	-- 		require("various-textobjs").setup({ useDefaultKeymaps = true })
	-- 	end,
	-- },
	{
		"anuvyklack/hydra.nvim",
		config = function()
			require("config.hydra")
		end,
	},
	-- {
	-- 	"mfussenegger/nvim-treehopper",
	-- 	-- config = true,
	-- 	dependencies = {
	-- 		"phaazon/hop.nvim",
	-- 	},
	-- },
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
		"sukima/xmledit",
		-- config = true,
		dependencies = {},
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

	"zef/vim-cycle",
	"junegunn/vim-easy-align",

	-- {
	-- 	"jbyuki/venn.nvim",
	-- 	-- config = true,
	-- 	dependencies = {},
	-- },
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
		"tpope/vim-surround", 
		-- config = false,
		-- opts = {},
		-- dependencies = {},
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

	-- "monaqa/dial.nvim",
	-- "alvan/vim-closetag",

	-- NAVIGATION

	-- "farmergreg/vim-lastplace",
	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		"cbochs/portal.nvim",
		config = function()
			require("config.portal")
		end,
    keys = {
      "<leader>i",
      "<leader>o"
    },
		dependencies = {},
	},
	{
		"simrat39/symbols-outline.nvim",
		config = true,
		dependencies = {},
	},
	{
		"cbochs/grapple.nvim",
		config = function()
			require("grapple").setup()
			vim.keymap.set("n", "<leader>M", require("grapple").toggle)
			vim.keymap.set("n", '<leader>"', require("grapple").popup_tags)
		end,
    cmd = {
      "GrapplePopup",
      "GrappleToggle",
      "GrappleCycle"
    },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"chentoast/marks.nvim",
		config = true,
		dependencies = {},
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
			"mrbjarksen/neo-tree-diagnostics.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
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
	-- {
	-- 	"LeonHeidelbach/trailblazer.nvim",
	-- 	config = true,
	-- 	dependencies = {},
	-- 	opts = {
	-- 		auto_save_trailblazer_state_on_exit = true,
	-- 		auto_load_trailblazer_state_on_enter = false,
	-- 		trail_options = {
	-- 			current_trail_mark_mode = "buffer_local_line_sorted",
	-- 			mark_symbol = "", --  will only be used if trail_mark_symbol_line_indicators_enabled = true
	-- 			newest_mark_symbol = "", -- disable this mark symbol by setting its value to ""
	-- 			cursor_mark_symbol = "", -- disable this mark symbol by setting its value to ""
	-- 			next_mark_symbol = "", -- disable this mark symbol by setting its value to ""
	-- 			previous_mark_symbol = "", -- disable
	-- 		},
	-- 		force_mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
	-- 			nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
	-- 				motions = {
	-- 					new_trail_mark = "<Leader>m",
	-- 					track_back = "<Leader>b",
	-- 					peek_move_next_down = "<Leader>j",
	-- 					peek_move_previous_up = "<Leader>k",
	-- 					move_to_nearest = "<Leader>n",
	-- 					toggle_trail_mark_list = "<Leader>'",
	-- 				},
	-- 				actions = {
	-- 					-- delete_all_trail_marks = "<Leader>L",
	-- 					-- paste_at_last_trail_mark = "<Leader>p",
	-- 					-- paste_at_all_trail_marks = "<Leader>P",
	-- 					-- set_trail_mark_select_mode = "<Leader>t",
	-- 					-- switch_to_next_trail_mark_stack = "<Leader>.",
	-- 					-- switch_to_previous_trail_mark_stack = "<Leader>,",
	-- 					-- set_trail_mark_stack_sort_mode = "<Leader>s",
	-- 				},
	-- 			},
	-- 			-- You can also add/move any motion or action to mode specific mappings i.e.:
	-- 			-- i = {
	-- 			--     motions = {
	-- 			--         new_trail_mark = '<C-l>',
	-- 			--         ...
	-- 			--     },
	-- 			--     ...
	-- 			-- },
	-- 		},
	-- 	},
	-- },
	-- {
	--   "stevearc/aerial.nvim",
	--   config = true,
	--   dependencies = {},
	-- },
	-- {
	--   "chentoast/marks.nvim",
	--   config = true,
	--   dependencies = {},
	-- },
	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- },

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
		"gelguy/wilder.nvim",
		config = function()
			require("wilder").setup({
				modes = { ":", "/" },
			})
			local wilder = require("wilder")
			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						language = "python",
						fuzzy = 0,
					}),
					wilder.python_search_pipeline({
						pattern = wilder.python_fuzzy_pattern(),
						sorter = wilder.python_difflib_sorter(),
						engine = "re",
					})
				),
			})
			wilder.set_option(
				"renderer",
				wilder.renderer_mux({
					[":"] = wilder.popupmenu_renderer({
						highlighter = wilder.basic_highlighter(),
					}),
					["/"] = wilder.wildmenu_renderer({
						highlighter = wilder.basic_highlighter(),
					}),
				})
			)
		end,
		build = {
			-- "pip install wheel && pip install pyre2"
			-- requires re2-devel
		},
		dependencies = {
			{
				"roxma/nvim-yarp",
				build = { "pip install -r requirements.txt", ":UpdateRemotePlugins" },
			},
		},
		-- event = { "CmdLineEnter" },
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		config = function()
			require("config.nvim-cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
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
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			{
				"hrsh7th/cmp-cmdline",
				config = function()
					-- require("config.nvim-cmp-cmd")
					-- require('cmp-cmdline').setup()
				end,
				dependencies = {},
			},
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
