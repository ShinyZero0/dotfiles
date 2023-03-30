require("Comment").setup({
	sticky = false,
})
---Textobject for adjacent commented lines
local function commented_lines_textobject()
	local U = require("Comment.utils")
	local cl = vim.api.nvim_win_get_cursor(0)[1] -- current line
	local range = { srow = cl, scol = 0, erow = cl, ecol = 0 }
	local ctx = {
		ctype = U.ctype.linewise,
		range = range,
	}
	local cstr = require("Comment.ft").calculate(ctx) or vim.bo.commentstring
	local ll, rr = U.unwrap_cstr(cstr)
	local padding = true
	local is_commented = U.is_commented(ll, rr, padding)

	local line = vim.api.nvim_buf_get_lines(0, cl - 1, cl, false)
	if next(line) == nil or not is_commented(line[1]) then
		return
	end

	local rs, re = cl, cl -- range start and end
	repeat
		rs = rs - 1
		line = vim.api.nvim_buf_get_lines(0, rs - 1, rs, false)
	until next(line) == nil or not is_commented(line[1])
	rs = rs + 1
	repeat
		re = re + 1
		line = vim.api.nvim_buf_get_lines(0, re - 1, re, false)
	until next(line) == nil or not is_commented(line[1])
	re = re - 1

	vim.fn.execute("normal! " .. rs .. "GV" .. re .. "G")
end

map("o", "ic", commented_lines_textobject, { silent = true, desc = "Textobject for adjacent commented lines" })

-- function ToggleMostComments(vmode)
-- 	local s = vim.api.nvim_buf_get_mark(0, "[")
-- 	local e = vim.api.nvim_buf_get_mark(0, "]")
-- 	local range = { srow = s[1], scol = s[2], erow = e[1], ecol = e[2] }
-- 	local ctx = {
-- 		ctype = U.ctype.linewise,
-- 		range = range,
-- 	}
-- 	local cstr = require("Comment.ft").calculate(ctx) or vim.bo.commentstring
-- 	local ll, rr = U.unwrap_cstr(cstr)
-- 	local padding = true
-- 	local is_commented = U.is_commented(ll, rr, padding)
--
-- 	local rcom = {} -- ranges of commented lines
-- 	local cl = s[1] -- current line
-- 	local rs, re = nil, nil -- range start and end
-- 	local lines = U.get_lines(range)
--
--
-- 	local cntComment, cntNoComment = 0, 0
--
-- 	for _, line in ipairs(lines) do
-- 		if U.is_commented(line) then
-- 			cntComment = cntComment + 1
-- 		else
-- 			cntNoComment = cntNoComment + 1
-- 		end
-- 	end
-- 	local toComment = false
-- 	if cntNoComment == cntComment then
-- 		if U.is_commented(lines[0]) then
-- 			toComment = false
-- 		else
-- 			toComment = true
-- 		end
-- 	elseif cntNoComment > cntComment then
-- 		toComment = true
-- 	else
-- 		toComment = false
-- 	end
-- 	if toComment then
-- 		for i, line in ipairs(lines) do
-- 			lines[i] = a.comment.linewise.current()
-- 		end
-- 	else
-- 		for i, line in ipairs(lines) do
-- 			lines[i] = U.uncomment_str(line, lcs, rcs, padding)
-- 		end
-- 	end
-- 	A.nvim_buf_set_lines(0, scol, ecol, false, lines)
-- end
