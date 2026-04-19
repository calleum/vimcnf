-- [nfnl] fnl/cal/util.fnl
local fun = require("cal.util.vendor.fun")
local function pretty_print_table(t, _3findent_arg)
  local indent = (_3findent_arg or 0)
  local toprint = (string.rep(" ", indent) .. "{\n")
  local new_indent = (indent + 2)
  local lines
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for k, v in pairs(t) do
      local val_28_
      do
        local k_str
        do
          local case_1_ = type(k)
          if (case_1_ == "number") then
            k_str = ("[" .. k .. "]")
          elseif (case_1_ == "string") then
            k_str = k
          else
            local _ = case_1_
            k_str = tostring(k)
          end
        end
        local v_str
        do
          local case_3_ = type(v)
          if (case_3_ == "number") then
            v_str = tostring(v)
          elseif (case_3_ == "string") then
            v_str = ("\"" .. v .. "\"")
          elseif (case_3_ == "table") then
            v_str = pretty_print_table(v, (new_indent + 2))
          else
            local _ = case_3_
            v_str = ("\"" .. tostring(v) .. "\"")
          end
        end
        val_28_ = (string.rep(" ", new_indent) .. k_str .. "= " .. v_str .. ",")
      end
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    lines = tbl_26_
  end
  return (toprint .. table.concat(lines, "\n") .. "\n" .. string.rep(" ", indent) .. "}")
end
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function reverse(xs)
  local len = fun.length(xs)
  local function _6_(n)
    return fun.nth((len - n), xs)
  end
  return fun.take(len, fun.tabulate(_6_))
end
local function view(list)
  local _7_
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for _, val in ipairs(list) do
      local val_28_ = ("[" .. val .. "]")
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    _7_ = tbl_26_
  end
  return table.concat(_7_, " | ")
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  local last_arg = last(args)
  local case_9_ = type(last_arg)
  if (case_9_ == "table") then
    local function _10_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_10_, last_arg, fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    local _ = case_9_
    return args
  end
end
local function extend_or_override(config, custom, ...)
  local case_12_ = type(custom)
  if (case_12_ == "function") then
    return (custom(config, ...) or config)
  elseif (case_12_ == "table") then
    return vim.tbl_deep_extend("force", config, custom)
  else
    local _ = case_12_
    return custom
  end
end
return {tx = tx, last = last, reverse = reverse, ["extend-or-override"] = extend_or_override, ["pretty-print-table"] = pretty_print_table, view = view}
