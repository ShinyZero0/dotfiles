local cmp = require("cmp")

cmp.setup.cmdline("/", {

	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = "wildmenu", separator = "  " },
	},
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {

	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man" },
			},
		},
	}),
})
