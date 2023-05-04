return {

	-- {
	-- 	"jghauser/fold-cycle.nvim",
	-- 	config = true,
	-- },
	{
		"sindrets/winshift.nvim",
		config = true,
	},
	{
		"kwkarlwang/bufresize.nvim",
	},
	{
		"mrjones2014/smart-splits.nvim",
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		config = true,
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
