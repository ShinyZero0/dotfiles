vim.g.neo_tree_remove_legacy_commands = 1

local function hopTree()
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
			["K"] = hopTree,
		},
	},
	sources = {

		"filesystem",
		"buffers",
		"git_status",
		"diagnostics",
	},
	event_handlers = {

		{
			event = "file_opened",
			handler = function(file_path)
				--auto close
				require("neo-tree").close_all()
			end,
		},
	},
	nesting_rules = {

		["axaml"] = { "axaml.cs" },
	},
	filesystem = {

		follow_current_file = true,
		filtered_items = {

			hide_by_pattern = {

				"*##*",
			},
		},
	},
})
