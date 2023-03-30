return {
	{
		"hrsh7th/cmp-cmdline",
		config = function()
			require("config.nvim-cmp-cmd")
		end,
		event = "CmdLineEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.nvim-cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			"dcampos/cmp-snippy",
			"onsails/lspkind.nvim",
			-- {
			-- 	"hrsh7th/cmp-nvim-lua",
			-- 	ft = "lua",
			-- },
		},
	},
	{
		"dcampos/cmp-snippy",
		event = "ModeChanged *:[vV\x16]*",
		dependencies = {
			{
				"dcampos/nvim-snippy",
				name = "snippy",
				config = true,
				dependencies = {
					"ShinyZero0/vim-snippets",
				},
			},
		},
	},
}
