require("lualine").setup({
	options = {
		theme = "challenger_deep",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = {

			{
				"tabs",
				tabs_color = {
					active = "lualine_c_inactive",
					inactive = "lualine_c_normal",
				},
			},
			-- {
			-- 	function()
			-- 		local reg = vim.fn.reg_recording()
			-- 		if reg ~= "" then
			-- 			return string.format("recording @%s", reg)
			-- 		else
			-- 			return ""
			-- 		end
			-- 	end,
			-- },
		},

		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = { "location" },
	},
})
