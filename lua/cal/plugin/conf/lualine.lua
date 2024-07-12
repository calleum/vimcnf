-- [nfnl] Compiled from fnl/cal/plugin/conf/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local ok_3f, lualine = pcall(require, "lualine")
if ok_3f then
  return lualine.setup()
else
  return nil
end
