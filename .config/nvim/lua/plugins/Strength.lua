--  ╭──────────────────────────────────────────────────────────╮
--  │                    Editing assistance                    │
--  ╰──────────────────────────────────────────────────────────╯

return {

	"tpope/vim-surround", -- place brackets and tags
	"tpope/vim-repeat", -- dot-repeat
	"tpope/vim-eunuch", -- filesystem util
	"junegunn/vim-easy-align", -- align columns
	"AndrewRadev/dsf.vim", -- delete surrounding function
	{
		"Wansmer/sibling-swap.nvim",
		opts = {
			use_default_keymaps = false,
			keymaps = {
				["<leader>w"] = "swap_with_right",
				["<leader>W"] = "swap_with_left",
				-- ["<space>."] = "swap_with_right_with_opp",
				-- ["<space>,"] = "swap_with_left_with_opp",
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
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
