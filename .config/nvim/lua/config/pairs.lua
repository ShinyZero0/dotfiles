local Pairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

Pairs.setup({
	ignored_next_char = "",
	map_cr = true,
})
Pairs.remove_rule("`")
require("nvim-autopairs").get_rule("[").not_filetypes = { "markdown" }
Pairs.add_rules({
	rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
	-- rule("<[^<>]*>", "</[^<>]*>", "xml"):use_regex(true),
})
