-- [nfnl] fnl/cal/util.fnl
local fun = require("cal.util.vendor.fun")
local function pretty_print_table(t, indent_arg)
  local indent = (indent_arg or 0)
  local toprint = (string.rep(" ", indent) .. "{\n")
  indent = (indent + 2)
  for k, v in pairs(t) do
    toprint = (toprint .. string.rep(" ", indent))
    if (type(k) == "number") then
      toprint = (toprint .. "[" .. k .. "] = ")
    elseif (type(k) == "string") then
      toprint = (toprint .. k .. "= ")
    else
    end
    if (type(v) == "number") then
      toprint = (toprint .. v .. ",\n")
    elseif (type(v) == "string") then
      toprint = (toprint .. "\"" .. v .. "\",\n")
    elseif (type(v) == "table") then
      toprint = (toprint .. pretty_print_table(v, (indent + 2)) .. ",\n")
    else
      toprint = (toprint .. "\"" .. tostring(v) .. "\",\n")
    end
  end
  toprint = (toprint .. string.rep(" ", (indent - 2)) .. "}")
  return toprint
end
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function reverse(xs)
  local len = fun.length(xs)
  local function _3_(n)
    return fun.nth((len - n), xs)
  end
  return fun.take(fun.length(xs), fun.tabulate(_3_))
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _4_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_4_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function extend_or_override(config, custom, ...)
  local new_config = nil
  if (type(custom) == "function") then
    new_config = (custom(config, ...) or config)
  elseif custom then
    new_config = vim.tbl_deep_extend("force", config, custom)
  else
  end
  return new_config
end
return {tx = tx, last = last, reverse = reverse, ["extend-or-override"] = extend_or_override, ["pretty-print-table"] = pretty_print_table}
