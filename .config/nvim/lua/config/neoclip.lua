local function is_whitespace(line)
	return vim.fn.match(line, [[^\s*$]]) ~= -1
end

require("neoclip").setup({
	default_register = "*",
	filter = function(data)
		return not All(data.event.regcontents, is_whitespace)
	end,
})
