local A = vim.api

A.nvim_create_autocmd("BufEnter", {

	desc = "Rid auto comment for new string",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

A.nvim_create_autocmd("BufEnter", {

	pattern = "*.cs",
	callback = function()
		vim.o.expandtab = true
	end,
})
