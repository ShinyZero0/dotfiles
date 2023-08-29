-- Nvim-treesitter

-- require("nvim-treesitter.install").compilers = { "clang", "clang++", "zig" }

require("nvim-treesitter.configs").setup({

	incremental_selection = { enable = true },
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"python",
		"c_sharp",
		"json",
		"markdown",
		"markdown_inline",
		"bash",
		"make",
	},
	auto_install = false,
	ignore_install = { "diff", "latex" },
	matchup = {
		enable = true,
	},
	highlight = {

		enable = true,

		disable = function(lang, buf)
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		query = "rainbow-parens",
		strategy = require("ts-rainbow").strategy.global,
	},
})
