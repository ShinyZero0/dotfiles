local M = {}

-- String interpolation{{{
function M.Interpolate(str)
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
end -- }}}
-- Aliases {{{
local f = M.Interpolate

M.map = vim.keymap.set
M.unmap = vim.keymap.del
M.noremap = function(modes, lhs, rhs)
	M.map(modes, lhs, rhs, { noremap = true })
end
M.mapcmd = function(modes, lhs, cmd, opts)
	M.map(modes, lhs, f("<CMD>{cmd}<CR>"), opts)
end
-- That's needed for visual mode sometimes
M.mapColon = function(modes, lhs, cmd, opts)
	M.map(modes, lhs, f(":{cmd}<CR>"), opts)
end -- }}}

return M
