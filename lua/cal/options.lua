-- [nfnl] Compiled from fnl/cal/options.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
nvim.ex.runtime_("plugin/default.vim")
nvim.ex.set("wrap")
nvim.ex.set("nocursorline")
nvim.ex.set("wildmode=full")
nvim.ex.set("wildoptions=pum")
nvim.ex.set("listchars-=eol:\226\134\181")
nvim.o.shiftwidth = 4
nvim.o.tabstop = 4
nvim.o.softtabstop = 4
nvim.o.scrolloff = 10
nvim.o.undodir = (nvim.fn.stdpath("data") .. "/undo")
nvim.ex.set("clipboard-=unnamedplus")
nvim.g.indent_blankline_char = "\226\148\138"
nvim.g.indent_blankline_filetype_exclude = {"help", "packer"}
nvim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
nvim.g.indent_blankline_char_highlight = "LineNr"
nvim.g.indent_blankline_show_trailing_blankline_indent = false
nvim.g.mkdp_echo_preview_url = 1
nvim.g.vimtex_view_method = "zathura"
return nil
