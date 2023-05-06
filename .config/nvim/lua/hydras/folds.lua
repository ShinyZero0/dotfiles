local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("config.hints")
vim.g.mapleader = " "

Hydra({

	name = "Folds",
	body = "z",
	config = {

		invoke_on_body = false,
		color = "pink",
		hint = { type = "window" },
	},
	mode = { "n", "v" },
	heads = {

		{ "j", "zj" },
		{ "k", "zk" },
		{ "x", "zx" },
		{ "o", "zo" },
		{ "O", "zO" },
		{ "c", "zc", { nowait = true } },
		{ "r", "zr" },
		{ "m", "zm" },
	},
})

-- vim:ft=lua
