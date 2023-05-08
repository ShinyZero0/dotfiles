return {
	{
		"hrsh7th/nvim-cmp",
		event = { "VeryLazy", "InsertEnter", "CmdLineEnter" },
		config = function()
			require("config.nvim-cmp")
		end,
		dependencies = {

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			"dcampos/cmp-snippy",
			"onsails/lspkind.nvim",
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
