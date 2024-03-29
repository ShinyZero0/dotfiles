-- Filesystem navigation assistance

return {

	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{ -- {{{
		"ShinyZero0/reach.nvim",
		dev = false,
		dir = "~/dev/vim/reach.nvim/",
		cmd = "ReachOpen",
		config = function()
			local reachOptions = {

				actions = {

					split = "<C-h>",
					vertsplit = "<C-v>",
					tabsplit = "<C-t>",
					delete = "<Space>",
				},
			}

			local Reach = require("reach")
			Reach.setup()

			map("n", "<Leader>b", function()
				Reach.buffers(reachOptions)
			end, {})
			map("n", "gt", function()
				Reach.tabpages(reachOptions)
			end, {})
			map({ "n", "v" }, "'", function()
				Reach.marks(reachOptions)
			end, {})
		end,
		keys = {

			"<Leader>b",
			"'",
			"gt",
		},
	}, -- }}}
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

	{
		"chentoast/marks.nvim",
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
		dependencies = { -- {{{

			"s1n7ax/nvim-window-picker",
			"mrbjarksen/neo-tree-diagnostics.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		}, -- }}}
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = true,
		opts = {

			selection_chars = "ASDFQWEHJKL",
			fg_color = "#ffe9aa",
			other_win_hl_color = "",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		cmd = "Telescope",
		branch = "0.1.x",
		dependencies = { -- {{{

			{
				"smartpde/telescope-recent-files",
				config = function()
					require("telescope").load_extension("recent_files")
				end,
			},
			{
				"crispgm/telescope-heading.nvim",
				config = function()
					require("telescope").load_extension("heading")
				end,
			},
			{
				"natecraddock/telescope-zf-native.nvim",
				config = function()
					require("telescope").load_extension("zf-native")
				end,
			},
			{
				"nvim-telescope/telescope-symbols.nvim",
				config = function()
					require("telescope").load_extension("neoclip")
				end,
			},
		}, -- }}}
	},
}
