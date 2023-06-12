local A = vim.api
local F = vim.fn
local f = require("Utils").Interpolate

-- Aliases

map = vim.keymap.set
unmap = vim.keymap.del
noremap = function(modes, lhs, rhs)
	map(modes, lhs, rhs, { noremap = true })
end
mapcmd = function(modes, lhs, cmd, opts)
	map(modes, lhs, f("<CMD>{cmd}<CR>"), opts)
end
mapColon = function(modes, lhs, cmd, opts)
	-- That's needed for visual mode sometimes
	map(modes, lhs, f(":{cmd}<CR>"), opts)
end

function All(tbl, check)
	for _, entry in ipairs(tbl) do
		if not check(entry) then
			return false
		end
	end
	return true
end

function SplitAtCursor()
	vim.cmd([[exe "normal i\<CR>\<ESC>^"]])
	local lineAboveNum = F.line(".") - 1
	local lineAbove = F.trim(F.getline(lineAboveNum), " ", 2)
	F.setline(lineAboveNum, lineAbove)
end

-- Recusively show and close all buffers when leaving the last window
function CoolExitFunc()
	local cnt = 0
	for _ in pairs(vim.api.nvim_list_wins()) do
		cnt = cnt + 1
	end
	if cnt == 1 then
		-- CoolerExitFunc()
		if vim.bo[0].modified or vim.bo[0].buftype == "terminal" then
			SaveOrExit:activate() -- Hydra will call the CoolerExitFunc
			return
		else
			vim.cmd("bd")
			CoolerExitFunc()
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
function CoolerExitFunc()
	for _, id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[id].modified or vim.bo[id].buftype == "terminal" then
			vim.cmd(f("buffer {id}"))
			SaveOrExit:activate() -- Hydra will call this function recusively
			return
		else
			vim.cmd(f("buffer {id} | silent! q!"))
		end
	end
end

-- Append delimiters
function ToggleEndingStuff()
	local charsMap = {
		cs = ";",
		zig = ";",
		nix = ";",
		lua = ",",
		nu = ",",
		markdown = "\\",
		json = ",",
		python = ":",
	}
	local char
	local ft = vim.bo[0].filetype
	if charsMap[ft] == nil then
		return
	end
	char = charsMap[ft]
	local line = vim.fn.getline(".")
	if string.sub(line, -#char) == char then
		line = string.sub(line, 0, -1 - #char)
	else
		line = line .. char
	end
	vim.fn.setline(".", line)
end
function FoldLevelByNames()
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
end
function FoldMethodByNames()
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
end
