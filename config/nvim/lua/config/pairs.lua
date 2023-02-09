require("nvim-autopairs").setup{}
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule("<",">","lua"))
npairs.add_rule(Rule("<",">","vim"))
npairs.add_rule(Rule("<",">","cs"))
