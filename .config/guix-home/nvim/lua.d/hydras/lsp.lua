local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
vim.g.mapleader = " "

Hydra({

	name = "Lsp diagnostics",
	body = "<Leader>d",
	config = {

		invoke_on_body = true,
		color = "pink",
		hint = { type = "window" },
	},
	mode = { "n" },
	heads = {

		{
			"d",
			function()
				require("hover").hover()
			end,
			{ nowait = true },
		},
		{ "a", vim.lsp.buf.code_action },
		{ "r", vim.lsp.buf.rename },
		{
			"R",
			function()
				require("telescope.builtin").lsp_references()
			end,
		},
		{ "N", vim.diagnostic.goto_prev },
		{ "n", vim.diagnostic.goto_next },
		{
			"i",
			function()
				require("telescope.builtin").lsp_implementations()
			end,
		},
	},
})

-- vim:ft=lua
