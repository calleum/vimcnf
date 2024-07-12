-- [nfnl] Compiled from fnl/cal/plugin/lint.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local function _1_()
  local lint = require("lint")
  lint.linters_by_ft = {markdown = {"markdownlint"}}
  local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
  local function _2_()
    return (require("lint")).try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {callback = _2_, group = lint_augroup})
end
return {uu.tx("mfussenegger/nvim-lint", {config = _1_, event = {"BufReadPre", "BufNewFile"}})}
