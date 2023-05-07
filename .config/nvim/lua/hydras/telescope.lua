local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
vim.g.mapleader = " "

Hydra({

	name = "Telescope",
	hint = hints.Telescope,
	config = {

		color = "teal",
		invoke_on_body = true,
		hint = {

			type = "window",
			position = "middle",
			border = "rounded",
		},
	},
	mode = "n",
	body = "<Leader>/",
	heads = {

		{ "b", cmd("Telescope buffers") },
		{ "c", cmd("Telescope command_history") },
		{ "g", cmd("Telescope live_grep") },
		{ "h", cmd("Telescope heading") },
		{ "j", cmd("Telescope jumplist") },
		{ "k", cmd("Telescope keymaps") },
		{ "l", cmd("Telescope highlights") },
		{ "q", cmd("Telescope quickfix") },
		{ "?", cmd("Telescope help_tags") },
		{ "r", cmd("Telescope recent_files pick") },
		{ "O", cmd("Telescope vim_options") },
		{ "'", cmd("Telescope marks") },
		{ '"', cmd("Telescope neoclip") },
		{ "/", cmd("Telescope current_buffer_fuzzy_find") },
		{ ";", cmd("Telescope commands") },
		{
			"f",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
		},

		{ "<Esc>", nil, { exit = true, nowait = true } },
		{ "<Enter>", cmd("Telescope") },
	},
})
