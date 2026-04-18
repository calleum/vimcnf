-- [nfnl] fnl/cal/plugin/neogen.fnl
local uu = require("cal.util")
local function generate_doc()
  return require("neogen").generate()
end
local function _1_()
  return require("neogen").setup({snippet_engine = "luasnip"})
end
return {uu.tx("danymat/neogen", {keys = {uu.tx("<leader>nd", generate_doc, {desc = "Generate Annotation"})}, config = _1_})}
