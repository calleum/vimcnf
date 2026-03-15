-- [nfnl] fnl/cal/plugin/which-key.fnl
local vim = _G.vim
local function _1_()
  require("which-key").setup({notify = false})
  vim.keymap.del("n", "grn")
  vim.keymap.del("n", "grr")
  vim.keymap.del("n", "gra")
  return require("which-key").add({{"<leader>c", group = "[C]ode"}, {"<leader>d", group = "[D]ocument"}, {"<leader>r", group = "[R]ename"}, {"<leader>s", group = "[S]earch"}, {"<leader>t", group = "[T]oggle"}, {"<leader>w", group = "[W]orkspace"}})
end
return {{"folke/which-key.nvim", config = _1_, event = "VimEnter"}}
