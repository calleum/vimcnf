local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/plugin/conf/sexp.fnl"
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
nvim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
return nil