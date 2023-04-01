return {
	{
		"akinsho/toggleterm.nvim",
		config = true,
	},
	{
		-- "ShinyZero0/haxe-mainfile.nvim",
		dir = "~/dev/vim/haxe-mainfile.nvim/",
		enabled = false,
		config = function()
			require("haxe-mainfile")
		end,
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
}
