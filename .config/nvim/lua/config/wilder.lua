require("wilder").setup({
	modes = { ":", "/" },
})
local wilder = require("wilder")
wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline({
			language = "python",
			fuzzy = 0,
		}),
		wilder.python_search_pipeline({
			pattern = wilder.python_fuzzy_pattern(),
			sorter = wilder.python_difflib_sorter(),
			engine = "re",
		})
	),
})
wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer({
			highlighter = wilder.basic_highlighter(),
		}),
		["/"] = wilder.wildmenu_renderer({
			highlighter = wilder.basic_highlighter(),
		}),
	})
)
