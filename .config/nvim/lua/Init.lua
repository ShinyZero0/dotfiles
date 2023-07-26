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
		["sxhkdrc"] = "sxhkdrc",
	},
	pattern = {
		[ [[.*/etc/wireguard/.*%.conf]] ] = "confini",
	},
})
require("Options")
require("Autorun")
