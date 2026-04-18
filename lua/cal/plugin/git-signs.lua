-- [nfnl] fnl/cal/plugin/git-signs.fnl
local uu = require("cal.util")
local function on_attach(bufnr)
  local gs = require("gitsigns")
  local maps
  local function _1_()
    if vim.wo.diff then
      return vim.cmd.normal({"]c", bang = true})
    else
      return gs.nav_hunk("next")
    end
  end
  local function _3_()
    if vim.wo.diff then
      return vim.cmd.normal({"[c", bang = true})
    else
      return gs.nav_hunk("prev")
    end
  end
  local function _5_()
    return gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
  end
  local function _6_()
    return gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
  end
  local function _7_()
    return gs.blame_line({full = true})
  end
  local function _8_()
    return gs.diffthis("~")
  end
  maps = {{"n", "]c", _1_, "Next Hunk"}, {"n", "[c", _3_, "Prev Hunk"}, {"n", "<leader>hs", gs.stage_hunk, "Stage Hunk"}, {"n", "<leader>hr", gs.reset_hunk, "Reset Hunk"}, {"v", "<leader>hs", _5_, "Stage Hunk"}, {"v", "<leader>hr", _6_, "Reset Hunk"}, {"n", "<leader>hS", gs.stage_buffer, "Stage Buffer"}, {"n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk"}, {"n", "<leader>hR", gs.reset_buffer, "Reset Buffer"}, {"n", "<leader>hp", gs.preview_hunk, "Preview Hunk"}, {"n", "<leader>hb", _7_, "Blame Line"}, {"n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Line Blame"}, {"n", "<leader>hd", gs.diffthis, "Diff This"}, {"n", "<leader>hD", _8_, "Diff This ~"}, {"n", "<leader>td", gs.toggle_deleted, "Toggle Deleted"}, {{"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk"}}
  for _, _9_ in ipairs(maps) do
    local mode = _9_[1]
    local lhs = _9_[2]
    local rhs = _9_[3]
    local desc = _9_[4]
    vim.keymap.set(mode, lhs, rhs, {buffer = bufnr, desc = desc})
  end
  return nil
end
return {uu.tx("lewis6991/gitsigns.nvim", {opts = {on_attach = on_attach, signs = {add = {text = "+"}, change = {text = "~"}, changedelete = {text = "~"}, delete = {text = "_"}, topdelete = {text = "\226\128\190"}}}})}
