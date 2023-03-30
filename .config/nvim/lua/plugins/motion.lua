return {
	"anuvyklack/vim-smartword",
	"chaoren/vim-wordmotion",
	{
		"abecodes/tabout.nvim",
		config = true,
		opts = {
			tabkey = "<C-Space>",
			backwards_tabkey = "<C-`>",
			act_as_tab = false,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "<", close = ">" },
			},
		},
		dependencies = {},
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_transmute_enabled = 1
			vim.cmd("let g:matchup_matchpref['xml'] = {'tagnameonly': 1}")
		end,
	},
	{
		"anuvyklack/hydra.nvim",
		config = function()
			require("config.hydra")
		end,
	},
	{
		"phaazon/hop.nvim",
		config = true,
	},
	-- {
	--  "mfussenegger/nvim-treehopper",
	--  -- config = true,
	--  dependencies = {
	--    "phaazon/hop.nvim",
	--  },
	-- },
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({ useDefaultKeymaps = true })
			unmap("x", "%")
		end,
	},
}
