require("nvim-autopairs").setup{}
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.add_rules(
{
    (Rule("<",">","lua"))
    -- :with_pair(cond.not_after_regex("%s"))
    -- :use_regex(true)
}
-- (Rule("<",">","vim"))
-- (Rule("<",">","xml"))
-- (Rule("<",">","cs"))
)
