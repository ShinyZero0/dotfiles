local A = vim.api
local Lsp = require("lspconfig")
require("cmp_nvim_lsp").setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local stdOpts = {
	capabilities = capabilities,
}

local omnisharpOpts = {

	capabilities = capabilities,
	cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
}

local lualsOpts = {

	settings = {

		Lua = {

			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {

				disable = {
					"lowercase-global",
				},
				globals = { "vim" },
			},
			workspace = {

				library = {

					vim.api.nvim_get_runtime_file("", true),
					vim.fn.stdpath("config"),
				},
				checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = capabilities,
}

local servers = {

	nil_ls = stdOpts,
	clangd = stdOpts,
	pyright = stdOpts,
	marksman = stdOpts,
	omnisharp = omnisharpOpts,
	lua_ls = lualsOpts,
}

for server, opts in pairs(servers) do
	Lsp[server].setup(opts)
end
local function onAttach()
	vim.call("RemapGotoDefinition")
	require("hydras.lsp")
end
A.nvim_create_autocmd("LspAttach", {
	callback = onAttach,
})

vim.diagnostic.config({

	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})
