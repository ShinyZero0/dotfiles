return {
	"nvim-lua/plenary.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		opts = {

			override = {

				["cs"] = {

					icon = "",
					color = "#95ffa4",
					name = "cs",
				},
				["xml"] = {

					icon = "",
					color = "#ffb378",
					name = "xml",
				},
			},
			override_by_extension = {

				["axaml"] = {

					icon = "",
					color = "#FFC3E1",
					name = "axaml",
				},
			},
		},
	},
}
