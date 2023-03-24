-- vim.g.neo_tree_remove_legacy_commands = 1
-- vim.cmd("let g:neo_tree_remove_legacy_commands = 1")
-- vim.g.neo_tree_remove_legacy_commands = 1
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
local function hop_tree()
	vim.cmd("HopLineStart")
end
require("neo-tree").setup({
	window = {
		position = "left",
		mappings = {
			["n"] = "add",
			["o"] = "open",
			["`"] = "toggle_hidden",
			["<Esc>"] = "close_window",
			["H"] = hop_tree,
		},
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"diagnostics",
	},
	filesystem = {
		-- hijack_netrw_behavior = "open_default",
	},
})
