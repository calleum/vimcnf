-- [nfnl] fnl/cal/plugin/cmp.fnl
local uu = require("cal.util")
local function _1_(ctx)
  return (ctx.mode ~= "cmdline")
end
local function _2_(ctx)
  return (ctx.mode ~= "cmdline")
end
return {uu.tx("saghen/blink.cmp", {version = "v0.*", opts = {keymap = {preset = "default", ["<C-space>"] = {"show", "show_documentation", "hide"}, ["<C-e>"] = {"hide"}, ["<C-y>"] = {"select_and_accept"}, ["<C-p>"] = {"select_prev", "fallback"}, ["<C-n>"] = {"select_next", "fallback"}, ["<C-b>"] = {"scroll_documentation_up", "fallback"}, ["<C-f>"] = {"scroll_documentation_down", "fallback"}}, completion = {list = {selection = {preselect = _1_, auto_insert = _2_}}, menu = {auto_show = true}, ghost_text = {enabled = true}}, appearance = {nerd_font_variant = "mono"}, sources = {default = {"lsp", "path", "snippets", "buffer"}}}, dependencies = {"rafamadriz/friendly-snippets"}})}
