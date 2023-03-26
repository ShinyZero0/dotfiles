local map = vim.keymap.set

local reachOptions = {
	actions = {
		split = "<C-s>",
		vertsplit = "<C-v>",
		tabsplit = "<C-t>",
		delete = "<Space>",
	},
}

map("n", "<Leader>b", function()
	require("reach").buffers(reachOptions)
end, {})
map("n", "gt", function()
	require("reach").tabpages(reachOptions)
end, {})
map("n", "'", function()
	require("reach").marks(reachOptions)
end, {})

map("n", "<C-h>", [[<Cmd>wincmd h<CR>]], {})
map({ "n", "t" }, "<C-j>", [[<Cmd>wincmd j<CR>]], {})
map({ "n", "t" }, "<C-k>", [[<Cmd>wincmd k<CR>]], {})
map("n", "<C-l>", [[<Cmd>wincmd l<CR>]], {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<C-`>", [[<C-\><C-n>]], {})
map(
	{ "n", "x" },
	"gC",
	"<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>g@",
	{ silent = true, desc = "Invert comments" }
)

-- map("n", '<leader>"', require("harpoon.ui").toggle_quick_menu, {})
-- map("n", "<leader>M", require("harpoon.mark").add_file, {})
-- map("n", "<leader>l", require("harpoon.ui").nav_next, {})
-- map("n", "<leader>h", require("harpoon.ui").nav_prev, {})
