-- call lsp hydra
pcall(function()
	require("config.hydra-alt")
end)
-- call gitsigns hydra
require("hydras.gitsigns")

local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local hints = require("config.hints")
local Splits = require("smart-splits")
vim.g.mapleader = " "

local function boolHint(option)
	local func = function()
		if vim.o[option] then
			return "[x]"
		else
			return "[ ]"
		end
	end
	return func
end

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

Hydra({

	name = "Options",
	mode = "n",
	body = "<Leader>O",
	hint = hints.Options,
	heads = {

		{ "s", cmd("set spell!") },
		{ "w", cmd("set wrap!") },
		{ "b", cmd("set linebreak!") },
		{ "V", cmd("set virtualedit!") },
		{ "R", cmd("set readonly!") },
		{ "C", cmd("ColorizerToggle") },
		{ "+", cmd("set cmdheight+=1") },
		{ "-", cmd("set cmdheight-=1") },

		{ "t", cmd("Telescope filetypes"), { exit = true } },
		{ "L", cmd("Lazy"), { exit = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
		{ "q", nil, { exit = true, nowait = true } },
		{ "<C-q>", nil, { exit = true, nowait = true } },
	},
	config = {

		color = "amaranth",
		invoke_on_body = true,
		hint = {

			position = "middle",
			border = "rounded",
			type = "window",
			funcs = {

				ro = boolHint("readonly"),
				lb = boolHint("linebreak"),
				ft = function()
					return vim.o.filetype
				end,
			},
		},
	},
})

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
})

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
})

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
						return "Wrong filetype!    "
					else
						return ""
					end
				end,
			},
		},
	},

	heads = {
		{ "e", cmd("Neoformat ToEng") },
		{ "r", cmd("Neoformat ToRus") },
		{ "s", cmd("Neoformat Split") },
		{ "j", cmd("Neoformat Join") },
		{ ".", cmd("Neoformat"), { exit = true } },
	},
})

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
		{ "e", ":Neoformat ToEng<CR>" },
		{ "r", ":Neoformat ToRus<CR>" },
		{ "s", ":Neoformat Split<CR>" },
		{ "j", ":Neoformat Join<CR>" },
		{ ".", ":Neoformat<CR>", { exit = true } },
	},
})

SaveOrExit = Hydra({

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
})

SaveOrExitOne = Hydra({

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
})

-- vim:sw=2:ts=2
