local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/keymap.fnl"
local uu = require("cal.util")
local vim = _G.vim
uu.remap("<S-F7>", ":%s/\\s\\+$//g<CR>", {})
uu.remap("n", "nzz", {noremap = true, silent = true})
uu.remap("N", "Nzz", {noremap = true, silent = true})
uu.remap("*", "*zz", {noremap = true, silent = true})
uu.remap("#", "#zz", {noremap = true, silent = true})
uu.remap("g*", "g*zz", {noremap = true, silent = true})
return uu.remap("/", "/\\v", {noremap = true, silent = false})