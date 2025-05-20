local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/plugin/conf/auto-pairs.fnl"
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
local function setup()
  local auto_pairs = nvim.g.AutoPairs
  if auto_pairs then
    auto_pairs["'"] = nil
    auto_pairs["`"] = nil
    nvim.b.AutoPairs = auto_pairs
    return nil
  else
    return nil
  end
end
__fnl_global___2amodule_2a["setup"] = setup
return augroup(__fnl_global__auto_2dpairs_2dconfig, nvim.ex.autocmd("FileType", "clojure,fennel,scheme", ("call v:lua.require('" .. __fnl_global___2amodule_2dname_2a .. "').setup()")))