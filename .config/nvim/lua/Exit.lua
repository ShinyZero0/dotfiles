-- Recusively show and close all buffers when leaving the last window
CoolExitFunc = function()
	local cnt = #vim.api.nvim_list_wins()
	if cnt == 1 then
		if vim.bo.modified or vim.bo.buftype == "terminal" then
			SaveOrExit:activate() -- Hydra will call the CoolerExitFunc
		else
			vim.cmd.bd()
			CoolerExitFunc()
		end
	else
		if vim.bo.modified then
			SaveOrExitOne:activate()
		else
			vim.cmd.quit()
		end
	end
end
-- continuation
CoolerExitFunc = function()
	local f = require("Utils").Interpolate
	for _, id in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[id].modified or vim.bo[id].buftype == "terminal" then
			vim.cmd(f("buffer {id}"))
			return SaveOrExit:activate() -- Hydra will call this function recusively
		else
			vim.cmd(f("buffer {id} | silent! q!"))
		end
	end
end
