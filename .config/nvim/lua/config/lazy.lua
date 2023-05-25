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
		lazy = false,
	},
	change_detection = {
		notify = false, -- get a notification when changes are found
	},
	git = {
		timeout = 300,
	},
	install = {
		colorscheme = { "challenger_deep" },
	},
})
-- vim.api.nvim_create_autocmd({ "User MainFile" }, { callback = "g:MainFile" })
-- vim.api.nvim_exec_autocmds({ "User MainFile" }, {})
