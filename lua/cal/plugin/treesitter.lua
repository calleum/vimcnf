-- [nfnl] Compiled from fnl/cal/plugin/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  require("nvim-treesitter.install")["prefer_git"] = true
  return (require("nvim-treesitter.configs")).setup(opts)
end
return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_, opts = {auto_install = true, ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "java", "typescript", "markdown", "vim", "vimdoc"}, highlight = {additional_vim_regex_highlighting = {"ruby"}, enable = true}, indent = {disable = {"ruby"}, enable = true}}}
