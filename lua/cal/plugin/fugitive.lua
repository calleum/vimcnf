-- [nfnl] fnl/cal/plugin/fugitive.fnl
local uu = require("cal.util")
local function review_quickfix(files_only)
  local pathspecs = {":(top)", ":(top,exclude,glob)**/*.lock", ":(top,exclude,glob)**/*-lock.json", ":(top,exclude,glob)**/pnpm-lock.yaml", ":(top,exclude,glob)**/bun.lockb", ":(top,exclude,glob)**/go.sum", ":(top,exclude,attr:linguist-generated)", ":(top,exclude,attr:linguist-generated=true)"}
  local args = {"Git", "difftool"}
  if files_only then
    table.insert(args, "--name-only")
  else
  end
  table.insert(args, "origin/HEAD...HEAD")
  table.insert(args, "--")
  for _, pathspec in ipairs(pathspecs) do
    table.insert(args, vim.fn.shellescape(pathspec))
  end
  vim.cmd(table.concat(args, " "))
  return vim.cmd("copen")
end
local function _2_()
  return review_quickfix(true)
end
local function _3_()
  return review_quickfix(false)
end
return {uu.tx("tpope/vim-fugitive", {keys = {uu.tx("<leader>sq", _2_, {desc = "Quickfix changed files (exclude locks/generated)"}), uu.tx("<leader>sQ", _3_, {desc = "Quickfix changed hunks (exclude locks/generated)"})}, lazy = false})}
