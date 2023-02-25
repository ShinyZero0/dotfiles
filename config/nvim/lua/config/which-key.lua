require("which-key").setup({
	ignore_missing = true,
	window = {
		border = "rounded",
	},
	plugins = {
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	-- triggers_blacklist = {
	-- 	c = { "s/", "s" },
	-- },
})
