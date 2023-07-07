local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require("cmp")
local lspkind = require("lspkind")
local snippy = require("snippy")

cmp.setup({

	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	experimental = {

		ghost_text = true,
		native_menu = false,
	},
	formatting = {
		format = lspkind.cmp_format(),
	},
	sources = cmp.config.sources({

		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "snippy" },
		{ name = "async_path" },
		{
			name = "buffer",
			option = {

				keyword_pattern = [[\k\+]],
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{
			name = "rg",
			keyword_length = 3,
		},
		{ name = "omni" },
		-- { name = "nvim_lsp_signature_help" },
	}),
	snippet = {

		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	window = {

		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {

		["<C-Tab>"] = cmp.mapping(function(fallback)
			if snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif snippy.can_jump(-1) then
				snippy.previous()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
})
