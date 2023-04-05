return {
	{
		"anuvyklack/hydra.nvim", -- keymap modes
		config = function()
			require("config.hydra")
		end,
	},
	{
		"akinsho/toggleterm.nvim", -- terminal emulator
		opts = {

			persist_mode = false,
		},
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
		"NvChad/nvim-colorizer.lua", -- highlight colors
		opts = {

			user_default_options = {

				names = false,
			},
		},
		cmd = "ColorizerToggle",
	},
}
