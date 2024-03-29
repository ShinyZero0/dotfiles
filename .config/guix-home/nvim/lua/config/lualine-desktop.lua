local Lualine = require("lualine")
Lualine.setup({

	-- options = { theme = "tundra" },
	options = { theme = "auto" },
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
		},

		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
-- local function show_macro()
--     if vim.fn.reg_recording() == " " then
--         return " "
--
--     end
-- end
