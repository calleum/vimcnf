(module cal.options
  {autoload {nvim aniseed.nvim}})

(nvim.ex.runtime_ "plugin/default.vim")

(nvim.ex.set :wrap)
(nvim.ex.set :nocursorline)
(nvim.ex.set "wildmode=full")
(nvim.ex.set "wildoptions=pum")
(nvim.ex.set "listchars-=eol:↵")

(set nvim.o.undodir (.. (nvim.fn.stdpath "data") "/undo"))

(nvim.ex.set "clipboard-=unnamedplus")

(set nvim.g.indent_blankline_char "┊")
(set nvim.g.indent_blankline_filetype_exclude [:help :packer])
(set nvim.g.indent_blankline_buftype_exclude [:terminal :nofile])
(set nvim.g.indent_blankline_char_highlight :LineNr)
(set nvim.g.indent_blankline_show_trailing_blankline_indent false)
(set nvim.g.mkdp_echo_preview_url 1)
(set nvim.g.vimtex_view_method :zathura)


