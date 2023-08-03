-- call hydras
require("hydras.git")
require("hydras.folds")
require("hydras.telescope")

local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
local Splits = require("smart-splits")
vim.g.mapleader = " "

local function _boolHint(option) -- {{{
	return function()
		if vim.o[option] then
			return "[x]"
		else
			return "[ ]"
		end
	end
end -- }}}

local function _reduceTabWidth() -- {{{
	if vim.o.tabstop > 1 then
		vim.o.tabstop = vim.o.tabstop / 2
		vim.o.shiftwidth = vim.o.tabstop
	end
end -- }}}
local function _increaseTabwidth() -- {{{
	vim.o.tabstop = vim.o.tabstop * 2
	vim.o.shiftwidth = vim.o.tabstop
end -- }}}
-- Options{{{
Hydra({

	name = "Options",
	mode = "n",
	body = "<Leader>O",
	hint = hints.Options,
	config = { -- {{{

		color = "amaranth",
		invoke_on_body = true,
		hint = {

			position = "middle",
			border = "rounded",
			type = "window",
			funcs = {

				ro = _boolHint("readonly"),
				lb = _boolHint("linebreak"),
				ft = function()
					return vim.o.filetype
				end,
			},
		},
	}, -- }}}
	heads = {

		{ "s", cmd("set spell!") },
		{ "w", cmd("set wrap!") },
		{ "b", cmd("set linebreak!") },
		{ "R", cmd("set readonly!") },
		{ "C", cmd("ColorizerToggle") },
		{ "+", _increaseTabwidth },
		{ "-", _reduceTabWidth },
		{ "t", cmd("Telescope filetypes"), { exit = true } },
		{ "L", cmd("Lazy"), { exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
		{ "q", nil, { exit = true, nowait = true } },
		{ "<C-q>", nil, { exit = true, nowait = true } },
	},
}) -- }}}

-- Windows{{{
Hydra({

	name = "Windows",
	config = {

		color = "amaranth",
		invoke_on_body = true,
		hint = {

			position = "middle",
			border = "rounded",
			type = "window",
		},
	},
	body = "<leader>W",
	heads = {

		{ "<Esc>", nil, { exit = true, nowait = true } },
		{ "o", vim.cmd.only, { exit = true } },
		{ "H", cmd("WinShift left") },
		{ "J", cmd("WinShift down") },
		{ "K", cmd("WinShift up") },
		{ "L", cmd("WinShift right") },
		{
			"h",
			function()
				Splits.resize_left(2)
			end,
		},
		{
			"j",
			function()
				Splits.resize_down(2)
			end,
		},
		{
			"k",
			function()
				Splits.resize_up(2)
			end,
		},
		{
			"l",
			function()
				Splits.resize_right(2)
			end,
		},
	},
}) -- }}}

-- Quick words{{{
Hydra({
	name = "Quick words",
	config = {
		invoke_on_body = true,
		color = "pink",
		hint = { type = "window" },
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
}) -- }}}

-- Formatting -- {{{
Hydra({
	name = "Formatting",
	body = "<Leader>.",
	hint = hints.Formatting,
	mode = { "n" },

	config = {

		invoke_on_body = true,
		color = "red",

		hint = {

			position = "middle",
			border = "rounded",
			type = "window",
			funcs = {
				ft = function()
					if vim.o.filetype ~= "text" then
						return "< Wrong filetype! >  "
					else
						return ""
					end
				end,
			},
		},
	},

	heads = {

		{ "e", cmd("Neoformat! markdown ToEng") },
		{ "r", cmd("Neoformat! markdown ToRus") },
		{ "s", cmd("Neoformat! markdown Split") },
		{ "j", cmd("Neoformat! markdown Join") },
		{ ".", cmd("Neoformat"), { exit = true } },
		{ "<Esc>", nil, { exit = true } },
	},
}) -- }}}

-- Formatting visual{{{
Hydra({

	name = "Formatting visual",
	body = "<Leader>.",
	hint = hints.Formatting,
	config = {

		invoke_on_body = true,
		color = "teal",
		hint = {

			position = "middle",
			border = "rounded",
			type = "window",
			funcs = {

				ft = function()
					if vim.o.filetype ~= "text" then
						return "Wrong filetype!    "
					else
						return ""
					end
				end,
			},
		},
	},
	mode = { "v" },
	heads = {

		{ "e", ":Neoformat! markdown ToEng<CR>" },
		{ "r", ":Neoformat! markdown ToRus<CR>" },
		{ "s", ":Neoformat! markdown Split<CR>" },
		{ "j", ":Neoformat! markdown Join<CR>" },
		{ ".", ":Neoformat<CR>", { exit = true } },
		{ "<Esc>", nil, { exit = true } },
	},
}) -- }}}

SaveOrExit = Hydra({ -- {{{

	name = "Are you sure?",
	hint = hints.SaveOrExit,
	config = {

		color = "blue",
		invoke_on_body = true,
		hint = {

			type = "window",
			position = "bottom",
			border = "rounded",
		},
	},
	heads = {

		{ "<C-q>", cmd("bd!|lua CoolerExitFunc()"), { desc = "Quit without saving" } },
		{ "q", cmd("bd!|lua CoolerExitFunc()"), { desc = "Quit without saving" } },
		{ "<C-s>", cmd("w|bd|lua CoolerExitFunc()"), { desc = "Save & quit" } },
		{ "s", cmd("w|bd|lua CoolerExitFunc()"), { desc = "Save & quit" } },
	},
}) -- }}}}}}

SaveOrExitOne = Hydra({ -- {{{

	name = "Are you sure?",
	hint = hints.SaveOrExit,
	config = {

		color = "blue",
		invoke_on_body = true,
		hint = {

			type = "window",
			position = "bottom",
			border = "rounded",
		},
	},
	heads = {

		{ "<C-q>", cmd("q!"), { desc = "Quit without saving" } },
		{ "q", cmd("q!"), { desc = "Quit without saving" } },
		{ "<C-s>", cmd("w|q"), { desc = "Save & quit" } },
		{ "s", cmd("w|q"), { desc = "Save & quit" } },
	},
}) -- }}}
