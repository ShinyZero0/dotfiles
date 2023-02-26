local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
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
			},
		},
	},
	pickers = {
		find_files = {
			follow = false,
			find_command = { "fd", "-H", "-d", "3" },
-- "-F", 
			mappings = {
				["i"] = {
					["<S-CR>"] = actions.select_tab,
					["<Del>"] = fb_actions.remove,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			initial_mode = "normal",
			scroll_strategy = "limit",
			-- hijack_netrw = true,
			grouped = true,
			hide_parent_dir = true,
			mappings = {
				["n"] = {
					["<Right>"] = actions.select_default,
					["<Left>"] = fb_actions.goto_parent_dir,
					["gh"] = fb_actions.goto_home_dir,
					["g\\"] = fb_actions.goto_cwd,
					["n\\"] = fb_actions.change_cwd,
					["nf"] = fb_actions.create,
					["/"] = function()
						vim.cmd("startinsert")
					end,
					["<BS>"] = fb_actions.toggle_hidden,
					["<S-CR>"] = actions.select_tab,
					["D"] = fb_actions.remove,
				},
				["i"] = {
					["<Esc>"] = function()
						vim.cmd("stopinsert")
					end,
					["<Del>"] = fb_actions.remove,
				},
			},
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
				},
			},
		},
		["zf-native"] = {
			-- options for sorting file-like items
			file = {
				-- override default telescope file sorter
				enable = true,

				-- highlight matching text in results
				highlight_results = true,

				-- enable zf filename match priority
				match_filename = true,
			},

			-- options for sorting all other items
			generic = {
				-- override default telescope generic item sorter
				enable = true,

				-- highlight matching text in results
				highlight_results = true,

				-- disable zf filename match priority
				match_filename = false,
			},
		},
	},
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("heading")
require("telescope").load_extension("zf-native")
