require("neo-tree").setup({
    window = {
        position = "floating",
        mappings = {
            ["<Esc>"] = "close_window",
        },
    },
	filesystem = {
		hijack_netrw_behavior = "open_default",
	},
})
