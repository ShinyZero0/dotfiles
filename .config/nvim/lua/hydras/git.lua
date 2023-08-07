local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")

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
		{ "co", "<Plug>(git-conflict-ours)" },
		{ "ct", "<Plug>(git-conflict-theirs)" },
		{ "cb", "<Plug>(git-conflict-both)" },
		{ "c0", "<Plug>(git-conflict-none)" },
		{ "[", cmd("GitConflictPrevConflict"), { nowait = true } },
		{ "]", cmd("GitConflictNextConflict"), { nowait = true } },
	},
})

-- vim:ft=lua
