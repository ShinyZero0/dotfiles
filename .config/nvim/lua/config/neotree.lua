require("neo-tree").setup({

	window = {
		position = "float",
		mappings = {
            ["n"] = "add",
			["<Esc>"] = "close_window",
		},
	},
	filesystem = {
		hijack_netrw_behavior = "open_default",
	},

})
