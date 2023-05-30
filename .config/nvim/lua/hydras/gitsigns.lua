local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
vim.g.mapleader = " "

Hydra({

	name = "GitSigns",
	body = "<Leader>g",
	config = {

		invoke_on_body = true,
		color = "pink",
		hint = { type = "window" },
	},
	mode = { "n" },
	heads = {

		{ "a", cmd("Gitsigns stage_hunk") },
		{ "u", cmd("Gitsigns undo_stage_hunk") },
		{ "p", cmd("Gitsigns preview_hunk_inline") },
		{ "n", cmd("Gitsigns next_hunk") },
		{ "N", cmd("Gitsigns prev_hunk") },
		{ "r", cmd("Gitsigns reset_hunk") },
		{ "[", cmd("GitConflictPrevConflict") },
		{ "]", cmd("GitConflictNextConflict") },
	},
})

-- vim:ft=lua
