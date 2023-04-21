--  ╭──────────────────────────────────────────────────────────╮
--  │                  Treesitter Textobjects                  │
--  ╰──────────────────────────────────────────────────────────╯

require("nvim-treesitter.configs").setup({

	textobjects = {

		select = {

			enable = true,
			keymaps = {

				["ip"] = "@parameter.inner",
				["ap"] = "@parameter.outer",
				["is"] = "@scope.inner",
				["as"] = "@scope.outer",
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
			},
		},
		move = {

			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {

				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["]p"] = "@parameter.inner",
				["]l"] = "@loop.*",
				["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {

				["]M"] = "@function.outer",
			},
			goto_previous_start = {

				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[p"] = "@parameter.inner",
				["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
			},
			goto_previous_end = {

				["[M"] = "@function.outer",
			},
			goto_next = {

				["]d"] = "@conditional.outer",
			},
			goto_previous = {

				["[d"] = "@conditional.outer",
			},
		},
		swap = {

			enable = true,
			swap_next = {

				[">p"] = "@parameter.inner",
			},
			swap_previous = {

				["<p"] = "@parameter.inner",
			},
		},
	},
})
