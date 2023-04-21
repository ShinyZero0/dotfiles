--  ╭──────────────────────────────────────────────────────────╮
--  │                    Editing assistance                    │
--  ╰──────────────────────────────────────────────────────────╯

return {

	"tpope/vim-surround", -- place brackets and tags
	"tpope/vim-repeat", -- dot-repeat
	"tpope/vim-eunuch", -- filesystem util
	"junegunn/vim-easy-align", -- align columns
	"AndrewRadev/dsf.vim", -- interact with surrounding function
	"fedepujol/move.nvim",
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("config.neoclip")
		end,
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
	},

	{
		"LudoPinelli/comment-box.nvim",
		opts = {

			line_blank_line_below = true,
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
