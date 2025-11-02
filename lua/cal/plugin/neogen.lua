-- [nfnl] fnl/cal/plugin/neogen.fnl
local uu = require("cal.util")
local function _1_()
  require("neogen").setup({snippet_engine = "luasnip"})
  local opts = {noremap = true, silent = true}
  return vim.api.nvim_set_keymap("n", "<Leader>nd", ":lua require('neogen').generate()<CR>", opts)
end
return {uu.tx("danymat/neogen", {config = _1_})}
