local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
vim.g.mapleader = " "

Hydra({

	name = "Folds",
	body = "z",
	config = {

		invoke_on_body = true,
		color = "pink",
		hint = { type = "window" },
	},
	mode = { "n", "v" },
	heads = {

		{ "n", "zj" },
		{ "N", "zk" },
		{ "x", "zx" },
		{ "X", "zX" },
		{ "o", "zo" },
		{ "O", "zO" },
		{ "c", "zc", { nowait = true } },
		{ "C", "zC", { nowait = true } },
		{ "m", "zm" },
		{ "M", "zM" },
		{ "r", "zr" },
		{ "R", "zR" },
	},
})

-- vim:ft=lua
