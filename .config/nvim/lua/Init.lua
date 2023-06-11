require("config.lazy")
vim.filetype.add({
	extension = {

		nu = "nu",
		kdl = "kdl",
		xaml = "xml",
		axaml = "xml",
	},
	filename = {

		["flake.lock"] = "json",
		["run"] = "sh",
	},
})
require("Options")
require("Autorun")
