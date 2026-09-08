-- [nfnl] fnl/cal/plugin/hardtime.fnl
local uu = require("cal.util")
return {uu.tx("m4xshen/hardtime.nvim", {dependencies = {"MunifTanjim/nui.nvim"}, opts = {disabled_keys = {["<Down>"] = false, ["<Up>"] = false}}, lazy = false})}
