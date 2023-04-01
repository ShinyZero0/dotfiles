-- REACH
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

map({ "n", "t" }, "<M-h>", [[<Cmd>wincmd h<CR>]], {})
map({ "n", "t" }, "<M-j>", [[<Cmd>wincmd j<CR>]], {})
map({ "n", "t" }, "<M-k>", [[<Cmd>wincmd k<CR>]], {})
map({ "n", "t" }, "<M-l>", [[<Cmd>wincmd l<CR>]], {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<C-`>", [[<C-\><C-n>]], {})
map(
	{ "n", "x" },
	"gC",
	"<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>g@",
	{ silent = true, desc = "Invert comments" }
)

-- SPECTRE
map("n", "<leader>S", function()
	require("spectre").open()
end, {
	desc = "Open Spectre",
})
map("n", "<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, {
	desc = "Search current word",
})
map("v", "<leader>sw", function()
	require("spectre").open_visual()
end, {
	desc = "Search current word",
})
map("n", "<leader>sp", function()
	require("spectre").open_file_search({ select_word = true })
end, {
	desc = "Search on current file",
})
-- map("n", '<leader>"', require("harpoon.ui").toggle_quick_menu, {})
-- map("n", "<leader>M", require("harpoon.mark").add_file, {})
-- map("n", "<leader>l", require("harpoon.ui").nav_next, {})
-- map("n", "<leader>h", require("harpoon.ui").nav_prev, {})
