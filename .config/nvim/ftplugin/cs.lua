require("Skills")
map("n", "gd", function()
	require("omnisharp_extended").lsp_definitions()
end, { buffer = true })
vim.g.neoformat_cs_csharpier = {

	exe = "dotnet-csharpier",
	stdin = 1,
	args = {},
}
vim.g.neoformat_cs_clangformat = {

	exe = "clang-format",
	stdin = 1,
	args = { "--style=Microsoft", "--assume-filename=.cs" },
}
vim.g.neoformat_cs_uncrustify = {
	exe = "uncrustify",
	stdin = 1,
	args = { "-l=CS", "-c", "~/.config/uncrustify.cfg" },
}
vim.g.neoformat_enabled_cs = { "csharpier", "uncrustify", "clangformat" }
