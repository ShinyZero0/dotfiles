local Pairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

Pairs.setup({

	ignored_next_char = "[\\]",
	map_cr = true,
	check_ts = true,
	enable_moveright = false,
	ts_config = {

		lua = { "string" }, -- it will not add a pair on that treesitter node
		c_sharp = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})
Pairs.remove_rule("`")
require("nvim-autopairs").get_rule("[").not_filetypes = { "markdown" }
require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }
Pairs.add_rules({

	rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
	-- rule("<[^<>]*>", "</[^<>]*>", "xml"):use_regex(true),
})
