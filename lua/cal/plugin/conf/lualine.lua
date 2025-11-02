-- [nfnl] fnl/cal/plugin/conf/lualine.fnl
local ok_3f, lualine = pcall(require, "lualine")
if ok_3f then
  return lualine.setup()
else
  return nil
end
