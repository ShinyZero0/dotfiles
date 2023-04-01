return {
	-- EDITING

	"tpope/vim-surround",
	"tpope/vim-repeat",
	-- "zef/vim-cycle",
	"junegunn/vim-easy-align",
	"AndrewRadev/dsf.vim",

	-- {
	--  "jbyuki/venn.nvim",
	--  -- config = true,
	--      -- },
	{
		"rktjmp/lush.nvim",
		config = false,
		dependencies = {},
	},
	{
		"sbdchd/neoformat",
		config = function() end,
		cmd = {
			"Neoformat",
		},
		opts = {},
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

	-- "preservim/nerdcommenter",
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
		"nvim-pack/nvim-spectre",
		cmd = {
			"Spectre",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- "alvan/vim-closetag",
}
