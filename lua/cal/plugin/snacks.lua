-- [nfnl] fnl/cal/plugin/snacks.fnl
local uu = require("cal.util")
local function _1_()
  local function _2_()
    if (vim.bo.filetype == "markdown") then
      return {win = {width = 80, wo = {signcolumn = "no", statuscolumn = "", number = false, relativenumber = false}}}
    else
      return nil
    end
  end
  return Snacks.zen(_2_())
end
local function _3_()
  return Snacks.zen.zoom()
end
local function _4_()
  return Snacks.scratch()
end
local function _5_()
  return Snacks.scratch.select()
end
local function _6_()
  return Snacks.notifier.show_history()
end
local function _7_()
  return Snacks.bufdelete()
end
local function _8_()
  return Snacks.notifier.hide()
end
local function _9_()
  return Snacks.win({file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], height = 0.6, width = 0.6, wo = {conceallevel = 3, signcolumn = "yes", statuscolumn = " ", spell = false, wrap = false}})
end
return {uu.tx("folke/snacks.nvim", {keys = {uu.tx("<leader>z", _1_, {desc = "Toggle Zen Mode"}), uu.tx("<leader>Z", _3_, {desc = "Toggle Zoom"}), uu.tx("<leader>.", _4_, {desc = "Toggle Scratch Buffer"}), uu.tx("<leader>S", _5_, {desc = "Select Scratch Buffer"}), uu.tx("<leader>n", _6_, {desc = "Notification History"}), uu.tx("<leader>bd", _7_, {desc = "Delete Buffer"}), uu.tx("<leader>un", _8_, {desc = "Dismiss All Notifications"}), uu.tx("<leader>N", _9_, {desc = "Neovim News"})}, opts = {bigfile = {enabled = true}, dashboard = {enabled = true}, dim = {animate = {enabled = false}}, explorer = {enabled = true}, input = {enabled = true}, notifier = {enabled = true, timeout = 3000}, picker = {enabled = true}, quickfile = {enabled = true}, statuscolumn = {enabled = true}, styles = {notification = {}}, zen = {win = {wo = {winhighlight = "Normal:Normal,NormalNC:Normal,NormalFloat:Normal"}, backdrop = {blend = 0, win = {wo = {winhighlight = "Normal:Normal,NormalNC:Normal"}}, transparent = false}}}, words = {enabled = true}}, priority = 1000, lazy = false})}
