return {

	{
		"stevearc/dressing.nvim",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {

			yadm = { enable = true },
		},
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = true,
	},
	{
		"lukas-reineke/headlines.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.blankline")
		end,
	},
	{
		"rebelot/heirline.nvim",
		enabled = falsea,
		config = function(...)
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
