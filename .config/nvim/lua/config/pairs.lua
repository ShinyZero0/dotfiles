local Npairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

require("npairs-int-upair").setup({
	map = "n", --which of them should be the insert mode autopair
	cmap = "u", --which of them should be the cmd mode autopair (only 'u' supported)
	bs = "u", --which of them should be the backspace
	cr = "n", --which of them should be the newline
	space = "u", --which of them should be the space (only 'u' supported)
	c_h = "", --which of them should be the <C-h> (only 'n' supported)
	c_w = "", --which of them should be the <C-w> (only 'n' supported)
	fastwarp = "", --ultimate-autopair's fastwarp mapping ('' for disable)
	rfastwarp = "", --ultimate-autopair's reverse fastwarp mapping ('' for disable)
	fastwrap = "", --nvim-autopairs's fastwrap mapping ('' for disable)
	npairs_conf = {}, --nvim-autopairs's configuration
	upair_conf = {}, --ultimate-autopair's configuration
})
-- Npairs.setup()
Npairs.remove_rule("`")
require("nvim-autopairs").get_rule("[").not_filetypes = { "markdown" }
require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }
-- Pairs.add_rules({
--
-- 	rule(" ", " "):with_pair(function(opts)
-- 		local pair = opts.line:sub(opts.col - 1, opts.col)
-- 		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
-- 	end),
-- })
