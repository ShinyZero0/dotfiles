-- Text navigation

return {

	"anuvyklack/vim-smartword",
	-- "chaoren/vim-wordmotion",
	{
		"chrisgrieser/nvim-spider",
		config = function()
			require("spider").setup({
				skipInsignificantPunctuation = false,
			})
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
			vim.keymap.set(
				{ "n", "o", "x" },
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				{ desc = "Spider-ge" }
			)
		end,
		dependencies = {},
	},
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
