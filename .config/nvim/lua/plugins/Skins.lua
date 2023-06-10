--  ╭──────────────────────────────────────────────────────────╮
--  │                          Themes                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

	{
		"loctvl842/monokai-pro.nvim",
		opts = {

			transparent_background = false,
			filter = "octagon",
		},
	},
	{
		"ShinyZero0/challenger-deep.nvim",
		-- dir = "~/dev/vim/challenger-deep.nvim/",
		lazy = false,
	},
	{
		"sam4llis/nvim-tundra",
		lazy = true,
		config = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"savq/melange",
		lazy = false,
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
