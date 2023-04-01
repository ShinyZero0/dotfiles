return {
	{
		"jdonaldson/vaxe",
		ft = "haxe",
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
		-- config = true,
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
	-- "Fymyte/rasi.vim",
	-- "lervag/vimtex",
}
