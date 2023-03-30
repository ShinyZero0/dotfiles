return {

	-- {
	--  "stevearc/oil.nvim",
	--  config = true,
	--      -- },
	{
		"mbbill/undotree",
	},
	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		-- "toppair/reach.nvim",
		"ShinyZero0/reach.nvim",
		-- dir = "~/dev/vim/reach.nvim/",
		config = true,
		cmd = "ReachOpen",
	},
	{
		"cbochs/portal.nvim",
		config = function()
			require("config.portal")
		end,
		keys = {
			"<leader>i",
			"<leader>o",
		},
	},
	-- {
	--  "simrat39/symbols-outline.nvim",
	--  config = true,
	--      -- },
	-- {
	--  "cbochs/grapple.nvim",
	--  config = function()
	--    require("grapple").setup()
	--    vim.keymap.set("n", "<leader>M", require("grapple").toggle)
	--    vim.keymap.set("n", '<leader>"', require("grapple").popup_tags)
	--  end,
	--  cmd = {
	--    "GrapplePopup",
	--    "GrappleToggle",
	--    "GrappleCycle",
	--  },
	--  dependencies = {
	--    "nvim-lua/plenary.nvim",
	--  },
	-- },
	-- {
	--     "nyngwang/suave.lua",
	--     config = true,
	--         -- },
	{
		"chentoast/marks.nvim",
		config = true,
		opts = {
			mappings = {
				next = "<Leader>j",
				prev = "<Leader>k",
			},
		},
	},

	-- {
	--     "nvim-tree/nvim-tree.lua",
	--     config = true,
	--     dependencies = {},
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			require("config.neotree")
		end,
		branch = "v2.x",
		cmd = "Neotree",
		dependencies = {
			"s1n7ax/nvim-window-picker",
			"mrbjarksen/neo-tree-diagnostics.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"s1n7ax/nvim-window-picker",
		config = true,
		lazy = true,
		opts = {
			selection_chars = "ASDFQW",
			fg_color = "#ffe9aa",
			other_win_hl_color = "",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
		cmd = {
			"Telescope",
		},
		branch = "0.1.x",
		dependencies = {
			"crispgm/telescope-heading.nvim",
			-- "nvim-telescope/telescope-file-browser.nvim",
			"natecraddock/telescope-zf-native.nvim",
		},
	},
}
