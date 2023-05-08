return {

	{
		"anuvyklack/hydra.nvim", -- keymap modes
		config = function()
			require("config.hydra")
		end,
		dependencies = {

			{
				"sindrets/winshift.nvim",
				config = true,
			},
			{
				"mrjones2014/smart-splits.nvim",
				lazy = true,
			},
		},
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
		"NvChad/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		opts = {

			user_default_options = {

				names = false,
				always_update = false,
			},
			filetypes = {
				cmp_docs = { always_update = true },
			},
		},
	},
}
