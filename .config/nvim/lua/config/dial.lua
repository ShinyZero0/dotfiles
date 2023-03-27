-- INCREMENT PLUGIN

local augend = require("dial.augend")
local function StdConstant(elems)
	return augend.constant.new({
		elements = elems,
		word = true,
		cyclic = true,
	})
end
require("dial.config").augends:register_group({
	default = {
		augend.constant.new({
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
		StdConstant({ "and", "or" }),
		StdConstant({ "&&", "||" }),
		StdConstant({ "==", "!=" }),
		StdConstant({ "-=", "+=" }),
		StdConstant({ "*=", "/=" }),
		StdConstant({ "True", "False" }),
		augend.integer.alias.decimal,
		augend.constant.alias.bool,
	},
})
