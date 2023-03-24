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

function CoolExitFunc()
	local cnt = 0
	for _ in pairs(vim.api.nvim_list_wins()) do
		cnt = cnt + 1
	end
	if cnt == 1 then
		-- CoolerExitFunc()
		if vim.bo[0].modified then
			SaveOrExit:activate()
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

function CoolerExitFunc()
	for _, id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[id].modified then
			vim.cmd(f("buffer {id}"))
			SaveOrExit:activate()
			return
		else
			vim.cmd(f("buffer {id} | silent! q!"))
		end
	end
end
