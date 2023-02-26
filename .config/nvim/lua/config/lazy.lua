local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup("plugins", {
	ui = {
		border = "rounded",
	},
	defaults = {
		-- lazy = false
	},
})

require("config.lsp")
require("config.lspsaga")

require("config.telescope")

require("config.treesitter")
require("config.blankline")

require("config.hydra")

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})

-- require("snippy").setup({})

-- require("color-picker").setup({
-- 	["icons"] = { "ﱢ", "" },
-- })

-- vim:ts=2:sw=2
