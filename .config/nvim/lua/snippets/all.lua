local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local types = require("luasnip.util.types")

return {
  s("zio", { 
      t({"ZIO."}) 
  }),
  s({ trig = "jdate", dscr = "Print current date"},
    f(function(args) 
      return os.date("%F")
    end, {})
  ),
  s("trigger", {
    	t({"", "After expanding, the cursor is here ->"}), i(1),
    	t({"After jumping forward once, cursor is here ->"}), i(2),
    	t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
  })
}
