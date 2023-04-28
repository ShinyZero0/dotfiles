return {
	{
		"anuvyklack/hydra.nvim", -- keymap modes
		config = function()
			require("config.hydra")
			pcall(function()
				require("config.hydra-alt")
			end)
		end,
	},
	-- {
	-- 	"akinsho/toggleterm.nvim", -- terminal emulator
	-- 	opts = {
	-- 		shell = "nu",
	-- 		persist_mode = false,
	-- 	},
	-- },
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
