local actions = require("telescope.actions")
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

			["n"] = { -- {{{

				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
				["q"] = actions.close,
				["<C-q>"] = actions.close,
			}, -- }}}
			["i"] = { -- {{{

				["<C-g>"] = function(prompt_bufnr)
					-- Use nvim-window-picker to choose the window by dynamically attaching a function
					local action_set = require("telescope.actions.set")
					local action_state = require("telescope.actions.state")
					local picker = action_state.get_current_picker(prompt_bufnr)
					picker.get_selection_window = function(picker, entry)
						local picked_window_id = require("window-picker").pick_window()
							or vim.api.nvim_get_current_win()
						-- Unbind after using so next instance of the picker acts normally
						picker.get_selection_window = nil
						return picked_window_id
					end

					return action_set.edit(prompt_bufnr, "edit")
				end,
				["<Esc>"] = actions.close,
				["<C-Esc>"] = function()
					vim.cmd("stopinsert")
				end,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab>"] = actions.move_selection_previous,
				["<C-q>"] = actions.close,
				["<S-CR>"] = actions.select_tab,
				["<C-BS>"] = { "<c-s-w>", type = "command" },
			}, -- }}}
		},
	},
	pickers = {

		find_files = {

			follow = false,
			find_command = { -- {{{

				"fd",
				"-H",
				"-d",
				"4",
				"-t",
				"f",
				"-t",
				"l",
			}, -- }}}
			mappings = {

				["i"] = {
					["<S-CR>"] = actions.select_tab,
				},
			},
		},
	},
	extensions = {

		["zf-native"] = { -- {{{

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
		}, -- }}}
	},
})
