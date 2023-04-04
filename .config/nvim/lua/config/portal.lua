require("portal").setup({

	labels = { "a", "s", "d", "f" },
	window_options = {

		relative = "editor",
		width = 80,
		height = 6,
		col = 10,
		-- focusable = false,
		-- border = "rounded",
		-- noautocmd = true,
	},
})
vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
