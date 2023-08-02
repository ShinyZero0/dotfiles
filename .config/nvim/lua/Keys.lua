-- Keymappings

-- imports -- {{{
local function ToggleEndingStuff()
	require("Skills").ToggleEndingStuff()
end
local function SplitAtCursor()
	require("Skills").SplitAtCursor()
end
local function CoolExitFunc()
	require("Skills").CoolExitFunc()
end -- }}}

noremap("n", "dD", "ddk") -- kill line & move up
-- yank & move down {{{
noremap("x", "gy", "y']")
noremap("x", "gy", "y']") -- }}}

noremap("n", "<LEADER>s", SplitAtCursor)
mapColon("c", "&", "'<,'>&")
map("i", "<C-a>", ToggleEndingStuff)
map("n", "<leader>a", ToggleEndingStuff)
map("i", "<C-e>", "<End>")
map("", "<C-q>", CoolExitFunc)
map({ "x", "n" }, "ga", "<Plug>(EasyAlign)")
map({ "x", "n" }, "<C-Tab>", "<Plug>(snippy-cut-text)")
-- newline{{{
map("n", "<CR>", function()
	local Fn = vim.fn
	Fn.append(".", "")
	Fn.setpos(".", {
		0,
		Fn.line(".") + 1,
		0,
	})
end) -- }}}
-- hop{{{
mapcmd("", "?", "HopPatternMW")
mapcmd("", "<C-w>", "HopWordMW")
mapcmd("", "K", "HopVertical")
mapcmd("", "<C-f>", "HopChar1") -- }}}

-- file nav{{{
mapcmd("n", "<Leader>t", "Neotree focus reveal")
mapcmd("n", "<Leader>f", "Telescope find_files")
mapcmd("n", "<Leader>r", "Telescope resume")
mapcmd("n", "<Leader>'", "Telescope marks") -- }}}

-- LITERAL NAVIGATION{{{
map("", "<C-left>", "g0")
map("", "<C-right>", "g$")
map("", "k", "gk")
map("", "j", "gj") -- }}}

-- terminal{{{
map("t", "<C-q>", [[<C-\><C-n><cmd>q<CR>]])
mapcmd("t", "<F5>", "q") -- }}}

-- Map system clipboard{{{
noremap({ "n", "x" }, "<Leader>y", '"+y')
noremap({ "n", "x" }, "<Leader>p", '"+p')
noremap({ "n", "x" }, "<Leader>P", '"+P') -- }}}

-- Switch windows with alt+{hjkl} {{{
mapcmd({ "n", "t" }, "<M-h>", "wincmd h", {})
mapcmd({ "n", "t" }, "<M-j>", "wincmd j", {})
mapcmd({ "n", "t" }, "<M-k>", "wincmd k", {})
mapcmd({ "n", "t" }, "<M-l>", "wincmd l", {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<C-`>", [[<C-\><C-n>]], {}) -- }}}

-- Command line {{{
noremap("c", "<C-left>", "<S-left>")
noremap("c", "<C-left>", "<S-left>")
noremap("c", "<C-right>", "<S-right>")
noremap("c", "<C-BS>", "<C-w>") -- }}}

-- Visual-mode commands{{{
mapColon("v", "<C-j>", "MoveBlock(1)", {})
mapColon("v", "<C-k>", "MoveBlock(-1)", {})
mapColon("v", "<C-h>", "MoveHBlock(-1)", {})
mapColon("v", "<C-l>", "MoveHBlock(1)", {}) -- }}}

-- MoveLine{{{
mapcmd("n", "<C-j>", "MoveLine(1)", {})
mapcmd("n", "<C-k>", "MoveLine(-1)", {})
mapcmd("n", "<C-h>", "MoveHChar(-1)", {})
mapcmd("n", "<C-l>", "MoveHChar(1)", {}) -- }}}

-- Dial{{{
map("n", "<C-a>", "<Plug>(dial-increment)")
map("n", "<C-x>", "<Plug>(dial-decrement)")
map("v", "<C-a>", "<Plug>(dial-increment)")
map("v", "<C-x>", "<Plug>(dial-decrement)")
map("v", "g<C-a>", "g<Plug>(dial-increment)")
map("v", "g<C-x>", "g<Plug>(dial-decrement)") -- }}}

-- Spectre{{{
local Spectre = require("spectre")

map("n", "<leader>SS", function()
	Spectre.open()
end, {})
map("n", "<leader>SW", function()
	Spectre.open_visual({ select_word = true })
end, {})
map("x", "<leader>S", function()
	Spectre.open_visual()
end, {})
map("n", "<leader>SF", function()
	Spectre.open_file_search({ select_word = true })
end, {}) -- }}}
