require('cmp_nvim_lsp').setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()

require("lspconfig")["pylsp"].setup {
    capabilities = capabilities
}

require('lspconfig')['texlab'].setup {
    capabilities = capabilities
}

-- require("lspconfig")[""]
require("lspconfig").sumneko_lua.setup {
    capabilities = capabilities
}

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/zero/.local/share/nvim/mason/bin/omnisharp"
require'lspconfig'.omnisharp.setup {
    capabilities = capabilities,
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) },
}
