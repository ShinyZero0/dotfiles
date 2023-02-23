require('lualine').setup {
	options = { theme = "challenger_deep" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
}
