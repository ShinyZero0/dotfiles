-- export aliases {{{
Utils = require("Utils")
map = Utils.map
mapcmd = Utils.mapcmd
unmap = Utils.unmap
noremap = Utils.noremap
mapColon = Utils.mapColon
-- }}}
-- setups {{{
require("Options").setup()
require("Autorun").setup()
require("config.lazy").setup() -- }}}

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
