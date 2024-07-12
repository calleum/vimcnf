-- [nfnl] Compiled from fnl/cal/util.fnl by https://github.com/Olical/nfnl, do not edit.
local fun = require("cal.util.vendor.fun")
local vim = _G.vim
local function get(t, k, d)
  local res
  if (type(t) == "table") then
    local val = t[k]
    if not (nil == val) then
      res = val
    else
      res = nil
    end
  else
    res = nil
  end
  if (nil == res) then
    return d
  else
    return res
  end
end
local function remap(from, to, opts)
  local map_opts = {noremap = true}
  do local _ = __fnl_global__extend_2dor_2doverride(opts, {callback = to}) end
  if get(opts, "local?") then
    return vim.keymap.set(0, "n", from, to, map_opts)()
  else
    return vim.keymap.set("n", from, to, map_opts)
  end
end
local function nnoremap(from, to, opts)
  return remap(from, to, opts)
end
local function nmap_ni(keys, func, desc)
  return vim.keymap.set("n", keys, func, {desc = desc})
end
local function lnnoremap(from, to)
  return nnoremap(("<leader>" .. from), to)
end
local function autoload(name)
  local res = {["aniseed/autoload-enabled?"] = true, ["aniseed/autoload-module"] = false}
  local function ensure()
    if res["aniseed/autoload-module"] then
      return res["aniseed/autoload-module"]
    else
      local m = require(name)
      do end (res)["aniseed/autoload-module"] = m
      return m
    end
  end
  local function _6_(_t, ...)
    return ensure()(...)
  end
  local function _7_(_t, k)
    return ensure()[k]
  end
  local function _8_(_t, k, v)
    ensure()[k] = v
    return nil
  end
  return setmetatable(res, {__call = _6_, __index = _7_, __newindex = _8_})
end
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
  local function _11_(n)
    return fun.nth((len - n), xs)
  end
  return fun.take(fun.length(xs), fun.tabulate(_11_))
end
local function dev_3f(plugin_name)
  return (1 == vim.fn.isdirectory((vim.fn.expand("~/repos/Olical") .. "/" .. plugin_name)))
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _12_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_12_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
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
local function safe_require_plugin_config(name)
  local ok_3f, val_or_err = pcall(require, ("cal.plugin." .. name))
  if not ok_3f then
    return print(("Plugin config error: " .. val_or_err))
  else
    return nil
  end
end
local function req(name)
  return ("require('cal.plugin." .. name .. "')")
end
return {autoload = autoload, ["dev?"] = dev_3f, tx = tx, last = last, reverse = reverse, expand = expand, glob = glob, ["exists?"] = __fnl_global__exists_3f, ["lua-file"] = __fnl_global__lua_2dfile, nnoremap = nnoremap, lnnoremap = lnnoremap, remap = remap, ["pretty-print-table"] = pretty_print_table, ["extend-or-override"] = extend_or_override}
