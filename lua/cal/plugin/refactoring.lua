-- [nfnl] fnl/cal/plugin/refactoring.fnl
local uu = require("cal.util")
local function select_refactor()
  return require("refactoring").select_refactor()
end
local function inline_variable()
  return require("refactoring").refactor("Inline Variable")
end
local function _1_()
  return require("refactoring").setup({})
end
return {uu.tx("ThePrimeagen/refactoring.nvim", {dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"}, keys = {uu.tx("<leader>rr", select_refactor, {desc = "Refactor: Select Refactor", mode = {"n", "x"}}), uu.tx("<leader>ri", inline_variable, {desc = "Refactor: Inline Variable", mode = {"n", "x"}, expr = true})}, config = _1_, lazy = false})}
