-- INCREMENT PLUGIN

local augend = require("dial.augend")
require("dial.config").augends:register_group({

	default = {

		augend.constant.new({

			elements = { "True", "False" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "public", "private" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "*=", "/=" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "+=", "-=" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "==", "!=" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
		augend.constant.new({

			elements = { "||", "&&" },
			word = true,
			cyclic = true,
		}),
		augend.hexcolor.new({

			case = "lower",
		}),
		augend.integer.alias.decimal,
		augend.constant.alias.bool,
	},
})
