-- [nfnl] Compiled from fnl/cal/plugin/git-signs.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(bufnr)
  local gitsigns = require("gitsigns")
  local function map(mode, l, r, opts)
    opts = (opts or {})
    opts.buffer = bufnr
    return vim.keymap.set(mode, l, r, opts)
  end
  local function _2_()
    if vim.wo.diff then
      return vim.cmd.normal({"]c", bang = true})
    else
      return gitsigns.nav_hunk("next")
    end
  end
  map("n", "]c", _2_)
  local function _4_()
    if vim.wo.diff then
      return vim.cmd.normal({"[c", bang = true})
    else
      return gitsigns.nav_hunk("prev")
    end
  end
  map("n", "[c", _4_)
  map("n", "<leader>hs", gitsigns.stage_hunk)
  map("n", "<leader>hr", gitsigns.reset_hunk)
  local function _6_()
    return gitsigns.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
  end
  map("v", "<leader>hs", _6_)
  local function _7_()
    return gitsigns.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
  end
  map("v", "<leader>hr", _7_)
  map("n", "<leader>hS", gitsigns.stage_buffer)
  map("n", "<leader>hu", gitsigns.undo_stage_hunk)
  map("n", "<leader>hR", gitsigns.reset_buffer)
  map("n", "<leader>hp", gitsigns.preview_hunk)
  local function _8_()
    return gitsigns.blame_line({full = true})
  end
  map("n", "<leader>hb", _8_)
  map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
  map("n", "<leader>hd", gitsigns.diffthis)
  local function _9_()
    return gitsigns.diffthis("~")
  end
  map("n", "<leader>hD", _9_)
  map("n", "<leader>td", gitsigns.toggle_deleted)
  return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end
return {"lewis6991/gitsigns.nvim", opts = {signs = {add = {text = "+"}, change = {text = "~"}, changedelete = {text = "~"}, delete = {text = "_"}, topdelete = {text = "\226\128\190"}}}, on_attach = _1_}
