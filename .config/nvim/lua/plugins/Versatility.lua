-- Filetypes support

return {

	{
		"eraserhd/parinfer-rust",
		ft = "scheme",
		build = "cargo build --release",
	},
	{
		"zdharma-continuum/zinit-vim-syntax",
		ft = "zsh",
	},
	{
		"sam4llis/nvim-lua-gf",
		ft = "lua",
	},
	{
		"ShinyZero0/xmledit",
		ft = "xml",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("config.ts-textobjects")
		end,
		dependencies = {

			"nvim-treesitter/nvim-treesitter",
		},
	},
}
