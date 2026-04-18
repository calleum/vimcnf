-- [nfnl] fnl/cal/plugin/which-key.fnl
local uu = require("cal.util")
local function setup_which_key()
  local wk = require("which-key")
  wk.setup({notify = false})
  for _, key in ipairs({"grn", "grr", "gra"}) do
    pcall(vim.keymap.del, "n", key)
  end
  return wk.add({uu.tx("<leader>c", {group = "[C]ode"}), uu.tx("<leader>d", {group = "[D]ocument"}), uu.tx("<leader>r", {group = "[R]ename"}), uu.tx("<leader>s", {group = "[S]earch"}), uu.tx("<leader>t", {group = "[T]oggle"}), uu.tx("<leader>w", {group = "[W]orkspace"})})
end
return {uu.tx("folke/which-key.nvim", {event = "VimEnter", config = setup_which_key})}
