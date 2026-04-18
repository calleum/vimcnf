-- [nfnl] fnl/cal/plugin/neotest.fnl
local uu = require("cal.util")
local function run_all_tests()
  return require("neotest").run.run(vim.fn.expand("%"))
end
local function _1_()
  return require("neotest").setup({adapters = {require("neotest-python"), require("neotest-plenary")}})
end
return {uu.tx("nvim-neotest/neotest", {dependencies = {"nvim-neotest/nvim-nio", "nvim-neotest/neotest-plenary", "nvim-neotest/neotest-python", "nvim-treesitter/nvim-treesitter"}, keys = {uu.tx("<leader>ra", run_all_tests, {desc = "[R]un [A]ll neotests in current file"})}, config = _1_})}
