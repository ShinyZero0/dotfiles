-- DESKTOP-SPECIFIC PLUGINS

return {

	"lambdalisue/suda.vim",

	-- LSP
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		ft = "cs",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},
	{
		"lewis6991/hover.nvim",
		event = "VeryLazy",
		-- Lazy = true,
		opts = {

			init = function()
				require("hover.providers.lsp")
			end,
			preview_opts = {

				border = nil,
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = false,
		},
	},
	{
		"tversteeg/registers.nvim", -- on termux the clipboard is fucking slow
		opts = {

			window = {

				max_width = 100,
				highlight_cursorline = true,
				border = "rounded",
				transparency = 10,
			},
		},
		keys = {

			{ '"', mode = { "n", "v" } },
			{ "<C-R>", mode = "i" },
		},
		cmd = "Registers",
	},
	-- {
	--     "ray-x/lsp_signature.nvim",
	--     config = true,
	-- },
}
-- vim:ts=2:sw=2:ft=lua
