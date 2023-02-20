local actions = require("telescope.actions")
local fb_actions = require "telescope".extensions.file_browser.actions
require("telescope").setup{
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        mappings = {
            ["n"] = {
                ["<leader>"] = actions.toggle_selection + actions.move_selection_next,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["q"] = actions.close,
                ["<C-q>"] = actions.close,
            },
            ["i"] = {
                ["<Esc>"] = actions.close,
                ["<C-Esc>"] = function() vim.cmd "stopinsert" end,

                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.close,
                ["<S-CR>"] = actions.select_tab,
            }
        },
    },

    extensions = {
        file_browser = {
            initial_mode = "normal",
            scroll_strategy = "limit",
            hijack_netrw = true,
            grouped = true,
            hide_parent_dir = true,
            mappings = {
                ["n"] = {
                    ["<Right>"] = actions.select_default,
                    ["<Left>"] = fb_actions.goto_parent_dir,
                    ["gh"] = fb_actions.goto_home_dir,
                    ["g\\"] = fb_actions.goto_cwd,
                    ["n\\"] = fb_actions.change_cwd,
                    ["nf"] = fb_actions.create,
                    ["/"] = function() vim.cmd "startinsert" end,
                    ["<BS>"] = fb_actions.toggle_hidden,
                    ["<S-CR>"] = actions.select_tab,
                    ["D"] = fb_actions.remove,
                    },
                ["i"] = {
                    ["<Esc>"] = function() vim.cmd "stopinsert" end,
                    ["<Del>"] = fb_actions.remove,
                },
            },
            layout_config = {
                horizontal = {
                    prompt_position = "bottom",
                },
            },
        },
    },
    pickers = {
        find_files = {
            follow = true,
            find_command = { "fd", "-H", "-F", "-d", "3" },
            mappings = {
                ["i"] = {
                    ["<S-CR>"] = actions.select_tab,
                    ["<Del>"] = fb_actions.remove,
                }
            }
        }
    }

}
require("telescope").load_extension "file_browser"
require("telescope").load_extension("heading")
