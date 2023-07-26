local A = vim.api
local Lsp = require("lspconfig")
require("cmp_nvim_lsp").setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local stdOpts = {
	capabilities = capabilities,
}

local specOpts = {

	omnisharpOpts = {

		cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },

		on_attach = function(client, bufnr)
			client.server_capabilities.semanticTokensProvider = nil
		end,
	},

	lualsOpts = {

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
	},
}
for _, opts in ipairs(specOpts) do
	for key, value in pairs(stdOpts) do
		if opts[key] == nil then
			opts[key] = value
		end
	end
end
local servers = {

	nil_ls = stdOpts,
	clangd = stdOpts,
	pyright = stdOpts,
	marksman = stdOpts,
	omnisharp = specOpts.omnisharpOpts,
	lua_ls = specOpts.lualsOpts,
}

for server, opts in pairs(servers) do
	Lsp[server].setup(opts)
end
local function onAttach()
	local function RemapGotoDefinition()
		if vim.bo.filetype == "cs" then
			return
		else
			mapcmd({ "n" }, "gd", "lua vim.lsp.buf.definition()")
		end
	end
	RemapGotoDefinition()
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
