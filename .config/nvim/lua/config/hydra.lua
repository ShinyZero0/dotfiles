local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("config.hints")
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
		{ "c", cmd("Telescope commands"), { desc = "execute command" } },
		{
			"f",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
		},
		{ "g", cmd("Telescope live_grep") },
		{ "h", cmd("Telescope heading"), { desc = "headings" } },
		{ "k", cmd("Telescope keymaps") },
		{ "l", cmd("Telescope highlights"), { desc = "highLights" } },
		{ "m", cmd("Telescope help_tags"), { desc = "vim help" } },
		{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
		{ "O", cmd("Telescope vim_options") },
		{ "p", cmd("Telescope projects"), { desc = "projects" } },
		-- { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
		{ "?", cmd("Telescope search_history"), { desc = "search history" } },
		{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
		{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
		{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})
Hydra({
	name = "Options",
	mode = "n",
	body = "<Leader>O",
	hint = hints.Options,
	config = {
		color = "red",
		invoke_on_body = true,
		hint = {
			position = "middle",
			border = "rounded",
			type = "window",
		},
		funcs = {},
	},
	heads = {
		{ "w", cmd("set wrap!") },
		{ "b", cmd("set linebreak!") },
		{ "R", cmd("set readonly!") },
		{ "L", cmd("Lazy"), { exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})

Hydra({
	name = "Quick words",
	config = {
		color = "pink",
		hint = { type = "cmdline" },
	},
	mode = { "n", "x", "o" },
	body = ",",
	heads = {
		{ "w", "<Plug>(smartword-w)" },
		{ "b", "<Plug>(smartword-b)" },
		{ "e", "<Plug>(smartword-e)" },
		{ "ge", "<Plug>(smartword-ge)" },
		{ "<Esc>", nil, { exit = true, mode = "n" } },
		{ ",", nil, { exit = true, nowait = true } },
	},
})

Hydra({
	name = "Lsp diagnostics",
	body = "<Leader>l",
	config = {
		color = "pink",
	},
	mode = { "n" },
	heads = {
		{ "d", cmd("Lspsaga hover_doc"), { nowait = true } },
		{ "l", cmd("Lspsaga show_line_diagnostics") },
		{ "a", cmd("Lspsaga code_action") },
		{
			"n",
			function()
				require("lspsaga.diagnostic"):goto_next()
			end,
		},
		{
			"N",
			function()
				require("lspsaga.diagnostic"):goto_prev()
			end,
		},
	},
})
-- vim:sw=2:ts=2
