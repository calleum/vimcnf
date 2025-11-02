-- [nfnl] fnl/cal/plugin/treesitter.fnl
local uu = require("cal.util")
local function _1_(_, opts)
  require("nvim-treesitter.install")["prefer_git"] = true
  return require("nvim-treesitter.configs").setup(opts)
end
return {uu.tx("nvim-treesitter/nvim-treesitter", {build = ":TSUpdate", dependencies = {"nvim-treesitter/nvim-treesitter-refactor"}, config = _1_, opts = {auto_install = true, refactor = {smart_rename = {enable = true, keymaps = {smart_rename = "grr"}}}, ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "java", "javascript", "typescript", "markdown", "vim", "vimdoc"}, highlight = {additional_vim_regex_highlighting = {"ruby"}, enable = true}, indent = {disable = {"ruby"}, enable = true}}}), uu.tx("nvim-treesitter/nvim-treesitter-textobjects", {dependencies = {"nvim-treesitter/nvim-treesitter"}}), uu.tx("nvim-treesitter/nvim-treesitter-context", {dependencies = {"nvim-treesitter/nvim-treesitter"}})}
