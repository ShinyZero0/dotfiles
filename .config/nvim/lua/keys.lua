local map = vim.keymap.set
function isAnyModified()
	local cnt = 0
	for _ in pairs(vim.api.nvim_list_wins()) do
		cnt = cnt + 1
	end
	if cnt == 1 then
		for _, id in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[id].buflisted and vim.bo[id].modified then
				SaveOrExit:activate()
				return
			end
		end
	end
	vim.cmd("quit")
end

map("n", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
map({ "n", "t" }, "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
map({ "n", "t" }, "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
map("n", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

-- map("n", '<leader>"', require("harpoon.ui").toggle_quick_menu, {})
-- map("n", "<leader>M", require("harpoon.mark").add_file, {})
-- map("n", "<leader>l", require("harpoon.ui").nav_next, {})
-- map("n", "<leader>h", require("harpoon.ui").nav_prev, {})