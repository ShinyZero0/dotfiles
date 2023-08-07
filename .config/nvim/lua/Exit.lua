-- Recusively show and close all buffers when leaving the last window
CoolExitFunc = function()
	local cnt = #vim.api.nvim_list_wins()
	if cnt == 1 then
		-- CoolerExitFunc()
		if vim.bo[0].modified or vim.bo[0].buftype == "terminal" then
			SaveOrExit:activate() -- Hydra will call the CoolerExitFunc
			return
		else
			vim.cmd("bd")
			CoolerExitFunc()
			return
		end
	else
		if vim.bo[0].modified then
			SaveOrExitOne:activate()
		else
			vim.cmd("quit")
		end
	end
end
-- continuation
CoolerExitFunc = function()
	local f = require("Utils").Interpolate
	for _, id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[id].modified or vim.bo[id].buftype == "terminal" then
			vim.cmd(f("buffer {id}"))
			SaveOrExit:activate() -- Hydra will call this function recusively
			return
		else
			vim.cmd(f("buffer {id} | silent! q!"))
		end
	end
end
