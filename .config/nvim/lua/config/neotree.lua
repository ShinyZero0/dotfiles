vim.g.neo_tree_remove_legacy_commands = 1

local function hop_tree()
	vim.cmd("HopLineStart")
end

require("neo-tree").setup({

	close_if_last_window = true,
	default_component_comfigs = {

		indent = {

			with_markers = true,
			indent_marker = " ",
			last_indent_marker = " ",
		},
	},
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
	nesting_rules = {

		["axaml"] = { "axaml.cs" },
	},
	filesystem = {

		filtered_items = {

			hide_by_pattern = {

				"*##*",
			},
		},
		-- hijack_netrw_behavior = "open_default",
	},
})
