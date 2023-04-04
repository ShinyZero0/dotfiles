local actions = require("telescope.actions")
-- local fb_actions = require("telescope").extensions.file_browser.actions
require("telescope").setup({

	defaults = {

		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {

			horizontal = {

				prompt_position = "top",
			},
		},
		mappings = {

			["n"] = {

				-- ["<leader>"] = actions.toggle_selection + actions.move_selection_next,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
				["q"] = actions.close,
				["<C-q>"] = actions.close,
			},
			["i"] = {

				["<Esc>"] = actions.close,
				["<C-Esc>"] = function()
					vim.cmd("stopinsert")
				end,

				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
				["<C-q>"] = actions.close,
				["<S-CR>"] = actions.select_tab,
				["<C-BS>"] = { "<c-s-w>", type = "command" },
			},
		},
	},
	pickers = {

		find_files = {

			follow = true,
			find_command = { "fd", "-H", "-d", "4" },
			mappings = {

				["i"] = {

					["<S-CR>"] = actions.select_tab,
					-- ["<Del>"] = fb_actions.remove,
				},
			},
		},
	},
	extensions = {

		["zf-native"] = {

			file = {

				enable = true,

				highlight_results = true,

				match_filename = true,
			},

			generic = {

				enable = false,

				highlight_results = true,

				match_filename = false,
			},
		},
	},
})
-- require("telescope").load_extension("file_browser")
require("telescope").load_extension("heading")
require("telescope").load_extension("zf-native")
require("telescope").load_extension("neoclip")
-- require("telescope").load_extension("harpoon")
