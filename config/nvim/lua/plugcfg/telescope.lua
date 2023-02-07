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
                [" "] = actions.toggle_selection + actions.move_selection_next,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["q"] = actions.close,
            },
            ["i"] = {
                ["<Esc>"] = actions.close,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
            }
        },
    },

    extensions = {
        file_browser = {
            initial_mode = "normal",
            scroll_strategy = "limit",
            layout_config = {
                horizontal = {
                    prompt_position = "bottom",
                },
            },
            hijack_netrw = true,
            grouped = true,
            hide_parent_dir = true,
            mappings = {
                ["n"] = {
                    ["<Right>"] = actions.select_default,
                    ["<Left>"] = fb_actions.goto_parent_dir,
                    ["gh"] = fb_actions.goto_home_dir,
                    ["g\\"] = fb_actions.goto_cwd,
                    ["c\\"] = fb_actions.change_cwd,
                    ["nf"] = fb_actions.create,
                    ["/"] = function() vim.cmd "startinsert" end
                    },
                ["i"] = {
                    ["<Esc>"] = function() vim.cmd "stopinsert" end
                },
            },
        },
    },
    pickers = {
        find_files = {
            follow = true,
            find_command = { "fd", "-H", "-F" }
        }
    }

}
require("telescope").load_extension "file_browser"
