require('cmp_nvim_lsp').setup()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["pylsp"].setup {
    capabilities = capabilities
}
require('lspconfig')['texlab'].setup {
    capabilities = capabilities
}
require("lspconfig")['vimls'].setup {
    capabilities = capabilities
}
require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
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
