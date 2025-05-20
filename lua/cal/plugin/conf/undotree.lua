local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/plugin/conf/undotree.fnl"
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
return nvim.set_keymap("n", "<leader>ut", ":UndotreeShow<cr>:UndotreeFocus<cr>", {noremap = true, silent = true})