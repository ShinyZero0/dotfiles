--  ╭──────────────────────────────────────────────────────────╮
--  │                         Aliases                          │
--  ╰──────────────────────────────────────────────────────────╯
map = vim.keymap.set
unmap = vim.keymap.del
mapcmd = function(modes, lhs, cmd, opts)
	map(modes, lhs, f("<CMD>{cmd}<CR>"), opts)
end
mapColon = function(modes, lhs, cmd, opts)
	map(modes, lhs, f(":{cmd}<CR>"), opts)
end

local A = vim.api

function All(tbl, check)
	for _, entry in ipairs(tbl) do
		if not check(entry) then
			return false
		end
	end
	return true
end

--  ╭──────────────────────────────────────────────────────────╮
--  │    Recusively show and close all buffers when leaving    │
--  │                     the last window                      │
--  ╰──────────────────────────────────────────────────────────╯
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

--  ╭──────────────────────────────────────────────────────────╮
--  │                   Append delimiters                      │
--  ╰──────────────────────────────────────────────────────────╯
function ToggleEndingStuff()
	local charsMap = {
		cs = ";",
		nix = ";",
		lua = ",",
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

--  ╭──────────────────────────────────────────────────────────╮
--  │                   String interpolation                   │
--  ╰──────────────────────────────────────────────────────────╯
function f(str)
	local outer_env = _ENV
	return (
		str:gsub("%b{}", function(block)
			local code = block:match("{(.*)}")
			local exp_env = {}
			setmetatable(exp_env, {

				__index = function(_, k)
					local stack_level = 5
					while debug.getinfo(stack_level, "") ~= nil do
						local i = 1
						repeat
							local name, value = debug.getlocal(stack_level, i)
							if name == k then
								return value
							end
							i = i + 1
						until name == nil
						stack_level = stack_level + 1
					end
					return rawget(outer_env, k)
				end,
			})
			local fn, err = load("return " .. code, "expression `" .. code .. "`", "t", exp_env)
			if fn then
				return tostring(fn())
			else
				error(err, 0)
			end
		end)
	)
end
function FoldByNames()
	local map = {
		[2] = { "*/.config/nvim/lua/plugins/*", "*" },
		[1] = { "*/.config/nvim/lua/config/*" },
	}
	for value, patterns in pairs(map) do
		for _, pattern in ipairs(patterns) do
			A.nvim_create_autocmd({ "BufEnter" }, {
				pattern = pattern,
				callback = function()
					vim.o.foldlevel = value
					vim.cmd.normal("zx")
				end,
			})
		end
	end
end
