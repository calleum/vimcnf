-- [nfnl] Compiled from fnl/cal/plugin/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  do end (require("which-key")).setup()
  return (require("which-key")).register({["<leader>c"] = {_ = "which_key_ignore", name = "[C]ode"}, ["<leader>d"] = {_ = "which_key_ignore", name = "[D]ocument"}, ["<leader>r"] = {_ = "which_key_ignore", name = "[R]ename"}, ["<leader>s"] = {_ = "which_key_ignore", name = "[S]earch"}, ["<leader>t"] = {_ = "which_key_ignore", name = "[T]oggle"}, ["<leader>w"] = {_ = "which_key_ignore", name = "[W]orkspace"}})
end
return {{"folke/which-key.nvim", config = _1_, event = "VimEnter"}}
