return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		config = function()
			require("config.nvim-cmp")
		end,
		keys = { ":", ";" },
		dependencies = {

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"FelipeLema/cmp-async-path",
			"hrsh7th/cmp-omni",
			"dcampos/cmp-snippy",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-rg",
			"hrsh7th/cmp-cmdline",
		},
	},
	{
		"hrsh7th/cmp-cmdline",
		config = function()
			require("config.nvim-cmp-cmd")
		end,
		lazy = true,
	},
	{
		"hrsh7th/cmp-nvim-lua",
		config = false,
		ft = { "lua" },
	},
	{
		"dcampos/cmp-snippy",
		event = "ModeChanged *:[vV\x16]*",
		dependencies = {
			{
				"dcampos/nvim-snippy",
				name = "snippy",
				config = true,
				ft = "snippets",
				dependencies = {

					"ShinyZero0/vim-snippets",
				},
			},
		},
	},
}
