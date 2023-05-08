local tabWidth = 4
local opts = {

	-- UI
	number = true,
	title = true,
	cursorline = true,
	showmode = false,
	scrolloff = 5,
	showtabline = 0,
	conceallevel = 0,
	splitright = true,
	splitbelow = true,
	termguicolors = true,

	-- Format
	tabstop = tabWidth,
	shiftwidth = tabWidth,
	breakindent = true,

	-- Fold
	foldenable = true,
	-- foldcolumn = "1",
	-- foldlevel = 99,
	-- foldlevelstart = 99,
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",

	-- Input
	completeopt = {
		"noselect",
	},
	pumheight = 10,
	whichwrap = vim.opt.whichwrap:append("<,>,[,],h,l"),
	timeoutlen = 5000,
	formatoptions = "1jtc",
	ignorecase = true,

	-- Stuff
	undofile = true,
	swapfile = false,
}

for key, value in pairs(opts) do
	vim.opt[key] = value
end

vim.g.vim_json_conceal = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0
vim.opt.fillchars:append({ diff = "╱" })
