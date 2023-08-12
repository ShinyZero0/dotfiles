return {

	{
		"kwkarlwang/bufresize.nvim",
		enabled = false,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		opts = {
			default_mappings = false,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		event = "VeryLazy",
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = true,
	},
	{
		"lukas-reineke/headlines.nvim",
		config = true,
		enabled = false, -- lagging
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.blankline")
		end,
	},
	{
		"rebelot/heirline.nvim",
		enabled = false,
		config = function()
			require("config.heirline")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		config = function()
			require("config.lualine")
		end,
		dependencies = {

			"ShinyZero0/challenger-deep.nvim",
		},
	},
}
