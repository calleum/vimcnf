-- [nfnl] fnl/cal/plugin/snacks.fnl
local uu = require("cal.util")
local function _1_()
  local S = require("snacks")
  return S.notifier.show_history()
end
local function _2_()
  local S = require("snacks")
  return S.notifier.hide()
end
return {uu.tx("folke/snacks.nvim", {priority = 1000, opts = {bigfile = {enabled = true}, notifier = {enabled = true}, quickfile = {enabled = true}, statuscolumn = {enabled = true}, words = {enabled = true}, styles = {notification = {wo = {wrap = true}}}}, keys = {{"<leader>n", ["2"] = _1_, desc = "Notification History"}, {"<leader>un", ["2"] = _2_, desc = "Dismiss All Notifications"}}, lazy = false})}
