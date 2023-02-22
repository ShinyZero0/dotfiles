require("neo-tree").setup({
    window = {
        mappings = {
            ["<Esc>"] = "close_window",
        },
    },
	filesystem = {
		hijack_netrw_behavior = "open_current",
	},
})
