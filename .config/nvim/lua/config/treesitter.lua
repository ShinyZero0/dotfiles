--  ╭──────────────────────────────────────────────────────────╮
--  │                     Nvim-treesitter                      │
--  ╰──────────────────────────────────────────────────────────╯

-- require("nvim-treesitter.install").compilers = { "clang", "clang++", "zig" }
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.nu = {

	install_info = {
		url = "https://github.com/nushell/tree-sitter-nu",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "nu",
}
require("nvim-treesitter.configs").setup({

	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"python",
		"c_sharp",
		"json",
		-- "nu",
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
