-- imports {{{
local A = vim.api
local Fn = vim.fn
local M = {} -- }}}

M.All = function(tbl, check) -- {{{
	for _, entry in ipairs(tbl) do
		if not check(entry) then
			return false
		end
	end
	return true
end -- }}}

M.SplitAtCursor = function() -- {{{
	vim.cmd([[exe "normal i\<CR>\<ESC>^"]])
	local lineAboveNr = Fn.line(".") - 1
	local lineAbove = Fn.trim(Fn.getline(lineAboveNr), " ", 2)
	Fn.setline(lineAboveNr, lineAbove)
end -- }}}

-- Recusively show and close all buffers when leaving the last window -- {{{
M.CoolExitFunc = function()
	local cnt = #vim.api.nvim_list_wins()
	if cnt == 1 then
		-- CoolerExitFunc()
		if vim.bo[0].modified or vim.bo[0].buftype == "terminal" then
			SaveOrExit:activate() -- Hydra will call the CoolerExitFunc
			return
		else
			vim.cmd("bd")
			M.CoolerExitFunc()
			return
		end
	else
		if vim.bo[0].modified then
			SaveOrExitOne:activate()
		else
			vim.cmd("quit")
		end
	end
end
-- continuation
M.CoolerExitFunc = function()
	local f = require("Utils").Interpolate
	for _, id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[id].modified or vim.bo[id].buftype == "terminal" then
			vim.cmd(f("buffer {id}"))
			SaveOrExit:activate() -- Hydra will call this function recusively
			return
		else
			vim.cmd(f("buffer {id} | silent! q!"))
		end
	end
end -- }}}

-- Append delimiters
M.ToggleEndingStuff = function() -- {{{
	local charsMap = { -- {{{

		cs = ";",
		zig = ";",
		nix = ";",
		lua = ",",
		nu = ",",
		markdown = "\\",
		zsh = "\\",
		sh = "\\",
		json = ",",
		python = ":",
		css = ";",
		javascript = ";",
		typescript = ";",
	} -- }}}
	local char = charsMap[vim.bo[0].filetype]
	if char == nil then
		return
	end
	local line = vim.fn.getline(".")
	if string.sub(line, -#char) == char then
		line = string.sub(line, 0, -1 - #char)
	else
		line = line .. char
	end
	vim.fn.setline(".", line)
end -- }}}
function FoldLevelByNames() -- {{{
	local map = {

		[2] = { "*/.config/nvim/lua/plugins/*" },
		[0] = { "*.nu" },
		[1] = { "*/.config/nvim/lua/config/*", "*" },
	}
	for value, patterns in pairs(map) do
		for _, pattern in ipairs(patterns) do
			A.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {

				pattern = pattern,
				callback = function()
					vim.o.foldlevel = value
					vim.cmd.normal("zx")
				end,
			})
		end
	end
end -- }}}
function FoldMethodByNames() -- {{{
	local map = {

		["indent"] = { "*.nu" },
		-- ["expr"] = { "*" },
	}
	for value, patterns in pairs(map) do
		for _, pattern in ipairs(patterns) do
			A.nvim_create_autocmd({ "BufEnter" }, {
				pattern = pattern,
				callback = function()
					vim.o.foldmethod = value
					vim.cmd.normal("zx")
				end,
			})
		end
	end
end -- }}}
return M
