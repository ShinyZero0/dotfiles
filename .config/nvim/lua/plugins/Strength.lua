--  ╭──────────────────────────────────────────────────────────╮
--  │                    Editing assistance                    │
--  ╰──────────────────────────────────────────────────────────╯

return {

	"tpope/vim-surround",
	"tpope/vim-repeat",
	-- "zef/vim-cycle",
	"junegunn/vim-easy-align",
	"AndrewRadev/dsf.vim",
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
		-- opts = {
		-- 	filter = nil,
		-- },
	},
	{
		"gbprod/stay-in-place.nvim",
		config = true,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({ useDefaultKeymaps = true })
			unmap("x", "%")
			map("x", "%", "<Plug>(matchup-%)")
			unmap("x", "r")
		end,
	},
	{
		"lfilho/cosco.vim",
		config = function()
			map("i", "<C-;>", "<C-o><Plug>(cosco-commaOrSemiColon)")
			map("n", "<C-;>", "<Plug>(cosco-commaOrSemiColon)")
		end,
		ft = { "cs", "c", "cpp" },
	},

	{
		"sbdchd/neoformat",
		config = function() end,
		cmd = {

			"Neoformat",
		},
	},
	{
		"monaqa/dial.nvim",
		config = function()
			require("config.dial")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("config.pairs")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
		-- keys = {
		--     "gc",
		-- },
		-- event = { "ModeChanged *:[vV\x16]*", "ModeChanged n:o*" },
	},

	{
		"LudoPinelli/comment-box.nvim",
		opts = {

			outer_blank_lines = true,
		},
	},

	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		dependencies = {

			"nvim-lua/plenary.nvim",
		},
	},
}
