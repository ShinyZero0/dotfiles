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
require("Options")
require("Autorun")
require("config.lazy")
