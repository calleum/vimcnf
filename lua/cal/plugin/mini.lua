-- [nfnl] fnl/cal/plugin/mini.fnl
local uu = require("cal.util")
local function setup_mini()
  require("mini.ai").setup()
  require("mini.surround").setup()
  local hipatterns = require("mini.hipatterns")
  local statusline = require("mini.statusline")
  hipatterns.setup({highlighters = {hex_color = hipatterns.gen_highlighter.hex_color()}})
  statusline.setup({use_icons = vim.g.have_nerd_font})
  local function _1_()
    return "%2l:%-2v"
  end
  statusline.section_location = _1_
  return nil
end
return {uu.tx("nvim-mini/mini.nvim", {config = setup_mini})}
