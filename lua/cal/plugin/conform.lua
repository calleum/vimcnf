-- [nfnl] fnl/cal/plugin/conform.fnl
local uu = require("cal.util")
local function _1_()
  return require("conform").format({async = true, lsp_format = "fallback"})
end
return {uu.tx("stevearc/conform.nvim", {keys = {uu.tx("<leader>f", _1_, "desc", "[F]ormat buffer", "mode", "")}, opts = {format_on_save = {lsp_format = "fallback", timeout_ms = 500}, formatters_by_ft = {lua = {"stylua"}, rust = {"rustfmt"}, vue = {"eslint_d"}, make = {"bake"}, bash = {"shfmt"}, sh = {"shfmt"}, json = {"jq"}, latex = {"tex-fmt"}, fennel = {"fnlfmt"}, nix = {"nixfmt"}, python = {"black"}}}, lazy = false})}
