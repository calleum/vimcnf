-- [nfnl] fnl/cal/plugin/neotest.fnl
local vim = _G.vim
local uu = require("cal.util")
local function _1_()
  require("neotest").setup({adapters = {require("neotest-python")({dap = {justMyCode = false}}), require("neotest-plenary")}})
  local function _2_()
    return require("neotest").run.run(vim.fn.expand("%"))
  end
  vim.keymap.set("n", "<leader>ra", _2_, {desc = "[R]un [A]ll neotests in current file"})
  return {"nvim-neotest/nvim-nio", "nvim-neotest/neotest-plenary", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter"}
end
return {uu.tx("nvim-neotest/neotest-python"), uu.tx("nvim-neotest/neotest-plenary"), uu.tx("nvim-neotest/neotest", {config = _1_})}
