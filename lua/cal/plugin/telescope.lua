-- [nfnl] Compiled from fnl/cal/plugin/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local function _1_()
  do end (require("telescope")).setup({extensions = {["ui-select"] = {(require("telescope.themes")).get_dropdown()}}})
  pcall((require("telescope")).load_extension, "fzf")
  pcall((require("telescope")).load_extension, "ui-select")
  pcall((require("telescope")).load_extension, "dap")
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "[S]earch [H]elp"})
  vim.keymap.set("n", "<leader>sk", builtin.keymaps, {desc = "[S]earch [K]eymaps"})
  vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "[S]earch [F]iles"})
  vim.keymap.set("n", "<leader>ss", builtin.builtin, {desc = "[S]earch [S]elect Telescope"})
  vim.keymap.set("n", "<leader>sw", builtin.grep_string, {desc = "[S]earch current [W]ord"})
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "[S]earch by [G]rep"})
  vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = "[S]earch [D]iagnostics"})
  vim.keymap.set("n", "<leader>sr", builtin.resume, {desc = "[S]earch [R]esume"})
  local function _2_()
    return (((require("telescope")).extensions).frecency).frecency({path_display = {"shorten"}, theme = "ivy", workspace = "CWD"})
  end
  vim.keymap.set("n", "<Leader>tf", _2_)
  vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {desc = "[S]earch Recent Files (\".\" for repeat)"})
  vim.keymap.set("n", "<leader><leader>", builtin.buffers, {desc = "[ ] Find existing buffers"})
  local function _3_()
    return builtin.current_buffer_fuzzy_find((require("telescope.themes")).get_dropdown({winblend = 10, previewer = false}))
  end
  vim.keymap.set("n", "<leader>/", _3_, {desc = "[/] Fuzzily search in current buffer"})
  local function _4_()
    return builtin.live_grep({grep_open_files = true, prompt_title = "Live Grep in Open Files"})
  end
  vim.keymap.set("n", "<leader>s/", _4_, {desc = "[S]earch [/] in Open Files"})
  local function _5_()
    return builtin.find_files({cwd = vim.fn.stdpath("config")})
  end
  return vim.keymap.set("n", "<leader>sn", _5_, {desc = "[S]earch [N]eovim files"})
end
local function _6_()
  return (vim.fn.executable("make") == 1)
end
local function _7_()
  return (require("telescope")).load_extension("frecency")
end
return {uu.tx("nvim-telescope/telescope.nvim", {branch = "0.1.x", config = _1_, dependencies = {"nvim-lua/plenary.nvim", uu.tx("nvim-telescope/telescope-dap.nvim", {lazy = true}), {"nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = _6_}, {"nvim-telescope/telescope-ui-select.nvim"}, {"nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font}, {"nvim-telescope/telescope-frecency.nvim", config = _7_}}, event = "VimEnter"})}
