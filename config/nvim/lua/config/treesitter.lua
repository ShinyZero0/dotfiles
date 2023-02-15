require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "help" },
    auto_install = true,
    ignore_install = { "diff", "latex" },

    highlight = {
        enable = true,

        disable = { "diff" },
        disable = function(lang, buf)
        local max_filesize = 1000 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then

            return true
            end
            end,

            additional_vim_regex_highlighting = false,
            },
}
