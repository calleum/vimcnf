-- [nfnl] Compiled from fnl/cal/plugin/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local vim = _G.vim
local function _1_()
  do end (require("which-key")).setup({notify = false})
  vim.keymap.del("n", "grn")
  vim.keymap.del("n", "grr")
  vim.keymap.del("n", "gra")
  return (require("which-key")).register({"<leader>c", group = "[C]ode"}, {"<leader>c_", hidden = true}, {"<leader>d", group = "[D]ocument"}, {"<leader>d_", hidden = true}, {"<leader>r", group = "[R]ename"}, {"<leader>r_", hidden = true}, {"<leader>s", group = "[S]earch"}, {"<leader>s_", hidden = true}, {"<leader>t", group = "[T]oggle"}, {"<leader>t_", hidden = true}, {"<leader>w", group = "[W]orkspace"}, {"<leader>w_", hidden = true})
end
return {{"folke/which-key.nvim", config = _1_, event = "VimEnter"}}
