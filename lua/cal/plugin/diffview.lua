-- [nfnl] fnl/cal/plugin/diffview.fnl
local uu = require("cal.util")
local function _1_()
  return vim.cmd("DiffviewOpen origin/HEAD")
end
vim.keymap.set("n", "<leader>dvh", _1_, {})
local function _2_()
  return vim.cmd("DiffviewOpen origin/main")
end
vim.keymap.set("n", "<leader>dvm", _2_, {})
local function _3_()
  return vim.cmd("DiffviewClose")
end
vim.keymap.set("n", "<leader>dvc", _3_, {})
local function _4_()
  return vim.cmd("DiffviewToggle")
end
vim.keymap.set("n", "<leader>dvt", _4_, {})
return {uu.tx("dlyongemallo/diffview.nvim")}
