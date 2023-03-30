require("cmp_nvim_lsp").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["clangd"].setup({
	capabilities = capabilities,
})
require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
})
require("lspconfig")["vimls"].setup({
	capabilities = capabilities,
})

local pid = vim.fn.getpid()
-- local omnisharp_bin = "/home/zero/.local/share/nvim/mason/bin/omnisharp"
local omnisharp_bin = "omnisharp"
require("lspconfig")["omnisharp"].setup({
	capabilities = capabilities,
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
	-- handlers = {
	--  ["textDocument/definition"] = require("omnisharp_extended").handler,
	-- },
})
-- require("lspconfig")["csharp_ls"].setup({
-- 	capabilities = capabilities,
-- })

require("lspconfig")["lua_ls"].setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
})
-- require("lspconfig")["pylsp"].setup({
--  capabilities = capabilities,
-- })
-- require("lspconfig")["ruff_lsp"].setup({
-- 	capabilities = capabilities,
-- })
-- require("lspconfig").jedi_language_server.setup({
--  capabilities = capabilities,
-- })
-- require("lspconfig")["texlab"].setup({
--  capabilities = capabilities,
-- })
