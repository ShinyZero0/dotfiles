return {
	{
		"stevearc/dressing.nvim",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		opts = {
			yadm = { enable = true },
		},
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = true,
		opts = {
			-- fill_char = "~",
		},
	},
	{
		"lukas-reineke/headlines.nvim",
		config = true,
		dependencies = {},
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
}
