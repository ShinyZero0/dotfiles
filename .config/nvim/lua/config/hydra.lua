-- call hydras
require("hydras.git")
require("hydras.folds")
require("hydras.telescope")

require("Exit")

local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("hydras.hints")
local Splits = require("smart-splits")

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
local function _increaseTabWidth() -- {{{
	vim.o.tabstop = vim.o.tabstop * 2
	vim.o.shiftwidth = vim.o.tabstop
end -- }}}
local function exitMapping(lhs)
	return { lhs, nil, { exit = true, nowait = true } }
end
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

		{ "w", cmd("set wrap!") },
		{ "b", cmd("set linebreak!") },
		{ "R", cmd("set readonly!") },
		{ "C", cmd("ColorizerToggle") },
		{ "+", _increaseTabWidth },
		{ "-", _reduceTabWidth },
		{ "t", cmd("Telescope filetypes"), { exit = true } },
		{ "L", cmd("Lazy"), { exit = true } },
		exitMapping("<Esc>"),
		exitMapping("q"),
		exitMapping("<C-q>"),
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

		exitMapping("<Esc>"),
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
		exitMapping(","),
	},
}) -- }}}

-- Formatting {{{
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
		},
	},
	mode = { "v", "n" },
	heads = {

		{ "e", ":Neoformat! markdown ToEng<CR>" },
		{ "r", ":Neoformat! markdown ToRus<CR>" },
		{ "s", ":Neoformat! markdown Split<CR>" },
		{ "j", ":Neoformat! markdown Join<CR>" },
		{ ".", ":Neoformat<CR>", { exit = true } },
		exitMapping("<Esc>"),
	},
}) -- }}}

local saveOrExitCfg = { -- {{{

	color = "blue",
	invoke_on_body = true,
	hint = {

		type = "window",
		position = "bottom",
		border = "rounded",
	},
} -- }}}
SaveOrExit = Hydra({ -- {{{

	name = "Are you sure?",
	hint = hints.SaveOrExit,
	config = saveOrExitCfg,
	heads = {

		{ "<C-q>", cmd("bd!|lua CoolerExitFunc()") },
		{ "q", cmd("bd!|lua CoolerExitFunc()") },
		{ "<C-s>", cmd("w|bd|lua CoolerExitFunc()") },
		{ "s", cmd("w|bd|lua CoolerExitFunc()") },
	},
}) -- }}}}}}

SaveOrExitOne = Hydra({ -- {{{

	name = "Are you sure?",
	hint = hints.SaveOrExit,
	config = saveOrExitCfg,
	heads = {

		{ "<C-q>", cmd("q!") },
		{ "q", cmd("q!") },
		{ "<C-s>", cmd("w|q") },
		{ "s", cmd("w|q") },
	},
}) -- }}}
