-- [nfnl] fnl/cal/plugin/vimtex.fnl
local vim = _G.vim
local uu = require("cal.util")
local function a()
  local function _1_()
    return vim.cmd("VimtexCompile")
  end
  vim.keymap.set("n", "<leader>ll", _1_)
  vim.g.vimtex_imaps_enabled = 0
  vim.g.tex_flavor = "latex"
  vim.g.vimtex_enabled = 1
  vim.g.vimtex_syntax_enabled = 0
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_compiler_latexmk = {options = {"-pdf", "-interaction=nonstopmode", "--shell-escape", "-synctex=1"}, out_dir = "build"}
  vim.g.vimtex_quickfix_enabled = 0
  vim.g.vimtex_delim_toggle_mod_list = {{"\\bigl", "\\bigr"}, {"\\Bigl", "\\Bigr"}, {"\\biggl", "\\biggr"}, {"\\Biggl", "\\Biggr"}}
  if (vim.fn.has("mac") == 1) then
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    return nil
  else
    return nil
  end
end
return {uu.tx("lervag/vimtex", {ft = "tex", config = a})}
