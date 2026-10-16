-- [nfnl] fnl/cal/plugin/fugitive.fnl
local uu = require("cal.util")
local function leave_review()
  local gs = require("gitsigns")
  gs.change_base(nil, true)
  gs.toggle_linehl(false)
  return vim.notify("Git review mode off")
end
local function review_quickfix(files_only)
  local pathspecs = {":(top)", ":(top,exclude,glob)**/*.lock", ":(top,exclude,glob)**/*-lock.json", ":(top,exclude,glob)**/pnpm-lock.yaml", ":(top,exclude,glob)**/bun.lockb", ":(top,exclude,glob)**/go.sum", ":(top,exclude,attr:linguist-generated)", ":(top,exclude,attr:linguist-generated=true)"}
  local args = {"Git", "difftool"}
  local root = vim.fn.FugitiveWorkTree()
  local base = vim.trim(vim.fn.system({"git", "-C", root, "merge-base", "origin/HEAD", "HEAD"}))
  if (vim.v.shell_error ~= 0) then
    return vim.notify(("Cannot start Git review: " .. base), vim.log.levels.ERROR)
  else
    if files_only then
      table.insert(args, "--name-only")
    else
    end
    table.insert(args, (base .. "..HEAD"))
    table.insert(args, "--")
    for _, pathspec in ipairs(pathspecs) do
      table.insert(args, vim.fn.shellescape(pathspec))
    end
    vim.cmd(table.concat(args, " "))
    do
      local gs = require("gitsigns")
      gs.change_base(base, true)
      gs.toggle_linehl(true)
    end
    return vim.cmd("copen")
  end
end
local function _3_()
  return review_quickfix(true)
end
local function _4_()
  return review_quickfix(false)
end
return {uu.tx("tpope/vim-fugitive", {dependencies = {"lewis6991/gitsigns.nvim"}, keys = {uu.tx("<leader>sq", _3_, {desc = "Quickfix changed files (exclude locks/generated)"}), uu.tx("<leader>sQ", _4_, {desc = "Quickfix changed hunks (exclude locks/generated)"}), uu.tx("<leader>se", leave_review, {desc = "Exit Git review mode"})}, lazy = false})}
