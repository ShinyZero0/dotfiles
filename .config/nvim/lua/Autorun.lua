vim.api.nvim_create_autocmd("BufEnter", {

	desc = "Rid auto comment for new string",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})
