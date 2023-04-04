require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "help", "python", "c_sharp" },
	auto_install = false,
	ignore_install = { "diff", "latex" },
	matchup = {
		enable = true,
	},
	highlight = {
		enable = true,

		disable = { "diff" },
		disable = function(lang, buf)
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		additional_vim_regex_highlighting = false,
	},
})
