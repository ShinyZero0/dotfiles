local M = {}
M.setup = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- {{{
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
	vim.opt.runtimepath:prepend(lazypath) -- }}}

	require("lazy").setup("plugins", {

		lockfile = os.getenv("HOME") .. ".local/share/lazy-lock.json",
		ui = {
			border = "rounded",
		},
		defaults = {
			lazy = false,
		},
		change_detection = {
			notify = false, -- get a notification when changes are found
		},
		install = {
			colorscheme = { "challenger_deep" },
		},
	})
end
return M
