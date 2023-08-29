-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"
vim.g.indent_blankline_filetype_exclude = {
	"scheme",
}
require("indent_blankline").setup({
	show_end_of_line = true,
})
