-- [nfnl] Compiled from fnl/cal/plugin/conf/undotree.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
return nvim.set_keymap("n", "<leader>ut", ":UndotreeShow<cr>:UndotreeFocus<cr>", {noremap = true, silent = true})
