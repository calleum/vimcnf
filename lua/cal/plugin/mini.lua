-- [nfnl] fnl/cal/plugin/mini.fnl
local uu = require("cal.util")
local function _1_()
  require("mini.ai").setup()
  require("mini.surround").setup()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({highlighters = {hex_color = hipatterns.gen_highlighter.hex_color()}})
  local statusline = require("mini.statusline")
  statusline.setup({use_icons = vim.g.have_nerd_font})
  local function _2_()
    return "%2l:%-2v"
  end
  statusline.section_location = _2_
  return nil
end
return uu.tx("nvim-mini/mini.nvim", {config = _1_})
