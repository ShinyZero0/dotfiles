-- Text navigation

return {

	"anuvyklack/vim-smartword",
	"chaoren/vim-wordmotion",
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_transmute_enabled = 1
			vim.g.matchup_surround_enabled = 1
			vim.cmd("let g:matchup_matchpref['xml'] = {'tagnameonly': 1}")
		end,
	},
	{
		"phaazon/hop.nvim",
		-- event = "VeryLazy",
		opts = {
			uppercase_labels = true,
		},
	},

	-- {
	--  "simrat39/symbols-outline.nvim",
	--  config = true,
	--      -- },

	-- {
	--  "mfussenegger/nvim-treehopper",
	--  -- config = true,
	--  dependencies = {
	--    "phaazon/hop.nvim",
	--  },
	-- },
}
