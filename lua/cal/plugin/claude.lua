-- [nfnl] fnl/cal/plugin/claude.fnl
local uu = require("cal.util")
local function _1_()
  local claude = require("claude-code")
  claude.setup({command = "AWS_REGION=us-east-1 claude"})
  return vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", {desc = "Toggle [C]laude [C]ode"})
end
return {uu.tx("greggh/claude-code.nvim", {config = _1_, dependencies = {"nvim-lua/plenary.nvim"}})}
