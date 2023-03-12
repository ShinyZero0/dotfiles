-- vim.g.neo_tree_remove_legacy_commands = 1
vim.cmd("let g:neo_tree_remove_legacy_commands = 1")

require("neo-tree").setup({
	window = {
		position = "float",
		mappings = {
			["n"] = "add",
			["<Esc>"] = "close_window",
		},
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"diagnostics",
	},
	filesystem = {
		hijack_netrw_behavior = "open_default",
	},
})
