require("lspsaga").setup({
    code_action = {
        num_shortcut = true,
        show_server_name = false,
        keys = {
            quit = { "q", "<ESC>" },
            exec = "<CR>",
        },
    },
})
