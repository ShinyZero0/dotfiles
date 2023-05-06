vim.filetype.add({
	extension = {
		nu = "nu",
		kdl = "kdl",
		xaml = "xml",
		axaml = "xml",
	},
	filename = {
		["flake.lock"] = "json",
	},
})
vim.opt.fillchars:append({ diff = "╱" })
-- FoldLevelByNames()
-- FoldMethodByNames()
