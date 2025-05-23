local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/plugin/lint.fnl"
local uu = require("cal.util")
local function _1_()
  local lint = require("lint")
  lint.linters_by_ft = {markdown = {"markdownlint"}, python = {"mypy"}, groovy = {"npm-groovy-lint"}}
  local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
  local function _2_()
    return (require("lint")).try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {callback = _2_, group = lint_augroup})
end
return {uu.tx("mfussenegger/nvim-lint", {config = _1_, event = {"BufReadPre", "BufNewFile"}})}