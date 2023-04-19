local Pairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

Pairs.setup()
Pairs.remove_rule("`")
require("nvim-autopairs").get_rule("[").not_filetypes = { "markdown" }
require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }
Pairs.add_rules({

	rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
})
