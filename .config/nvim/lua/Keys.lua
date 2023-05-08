map("n", "<LEADER>s", "i<CR><ESC>^")
map("i", "<C-a>", ToggleEndingStuff)
map("n", "<leader>a", ToggleEndingStuff)
mapcmd("n", "<Leader>w", "ArgWrap")

-- Switch windows on alt_hjkl
mapcmd({ "n", "t" }, "<M-h>", "wincmd h", {})
mapcmd({ "n", "t" }, "<M-j>", "wincmd j", {})
mapcmd({ "n", "t" }, "<M-k>", "wincmd k", {})
mapcmd({ "n", "t" }, "<M-l>", "wincmd l", {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<C-`>", [[<C-\><C-n>]], {})

-- MoveLine
mapcmd("n", "<C-j>", "MoveLine(1)", {})
mapcmd("n", "<C-k>", "MoveLine(-1)", {})
mapcmd("n", "<C-h>", "MoveHChar(-1)", {})
mapcmd("n", "<C-l>", "MoveHChar(1)", {})

-- Visual-mode commands
mapColon("v", "<C-j>", "MoveBlock(1)", {})
mapColon("v", "<C-k>", "MoveBlock(-1)", {})
mapColon("v", "<C-h>", "MoveHBlock(-1)", {})
mapColon("v", "<C-l>", "MoveHBlock(1)", {})

map("n", "<C-a>", "<Plug>(dial-increment)")
map("n", "<C-x>", "<Plug>(dial-decrement)")
map("v", "<C-a>", "<Plug>(dial-increment)")
map("v", "<C-x>", "<Plug>(dial-decrement)")
map("v", "g<C-a>", "g<Plug>(dial-increment)")
map("v", "g<C-x>", "g<Plug>(dial-decrement)")

-- Reach.nvim
local reachOptions = {

	actions = {

		split = "<C-h>",
		vertsplit = "<C-v>",
		tabsplit = "<C-t>",
		delete = "<Space>",
	},
}

local Reach = require("reach")

map("n", "<Leader>b", function()
	Reach.buffers(reachOptions)
end, {})
map("n", "gt", function()
	Reach.tabpages(reachOptions)
end, {})
map("n", "'", function()
	Reach.marks(reachOptions)
end, {})

-- SPECTRE
local Spectre = require("spectre")

map("n", "<leader>SS", function()
	Spectre.open()
end, {})
map("n", "<leader>SW", function()
	Spectre.open_visual({ select_word = true })
end, {})
map("v", "<leader>S", function()
	Spectre.open_visual()
end, {})
map("n", "<leader>SF", function()
	Spectre.open_file_search({ select_word = true })
end, {})
