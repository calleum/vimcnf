-- [nfnl] fnl/cal/plugin/refactoring.fnl
local vim = _G.vim
local function _1_()
  require("refactoring").setup({})
  local function _2_()
    return require("refactoring").refactor("Inline Variable")
  end
  vim.keymap.set({"n", "x"}, "<leader>ri", _2_, {expr = true})
  local function _3_()
    return require("refactoring").select_refactor()
  end
  return vim.keymap.set({"n", "x"}, "<leader>rr", _3_, {desc = "Refactor: Select Refactor", noremap = true, silent = true})
end
return {"ThePrimeagen/refactoring.nvim", config = _1_, dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"}, keys = {{"<leader>rr", desc = "Refactor: Select Refactor", mode = {"n", "x"}}}, lazy = false}
