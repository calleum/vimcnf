-- [nfnl] Compiled from fnl/cal/plugin/conf/auto-pairs.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
local function _1_(...)
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
defn(setup, {}, _1_(...))
return augroup(__fnl_global__auto_2dpairs_2dconfig, nvim.ex.autocmd("FileType", "clojure,fennel,scheme", ("call v:lua.require('" .. __fnl_global___2amodule_2dname_2a .. "').setup()")))
