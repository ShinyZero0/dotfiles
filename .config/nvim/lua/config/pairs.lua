require("nvim-autopairs").setup({})
local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")

npairs.add_rules(
	{
		Rule("<", ">", "lua"),
		Rule(" ", " "):with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({ "()", "[]", "{}" }, pair)
		end),
		-- :with_pair(cond.not_after_regex("%s"))
		-- :use_regex(true)
	}
	-- (Rule("<",">","vim"))
	-- (Rule("<",">","xml"))
	-- (Rule("<",">","cs"))
)
