-- [nfnl] fnl/cal/plugin/telescope.fnl
local uu = require("cal.util")
local function _1_()
  require("telescope").setup({extensions = {["ui-select"] = {require("telescope.themes").get_dropdown({layout_config = {width = 0.9}})}}})
  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "ui-select")
  pcall(require("telescope").load_extension, "dap")
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "[S]earch [H]elp"})
  vim.keymap.set("n", "<leader>sk", builtin.keymaps, {desc = "[S]earch [K]eymaps"})
  vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "[S]earch [F]iles"})
  vim.keymap.set("n", "<leader>ss", builtin.builtin, {desc = "[S]earch [S]elect Telescope"})
  vim.keymap.set("n", "<leader>sw", builtin.grep_string, {desc = "[S]earch current [W]ord"})
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "[S]earch by [G]rep"})
  vim.keymap.set("n", "<leader>sd", builtin.diagnostics, {desc = "[S]earch [D]iagnostics"})
  vim.keymap.set("n", "<leader>sr", builtin.resume, {desc = "[S]earch [L]references"})
  vim.keymap.set("n", "<leader>s.", builtin.oldfiles, {desc = "[S]earch Recent Files (\".\" for repeat)"})
  vim.keymap.set("n", "<leader><leader>", builtin.buffers, {desc = "[ ] Find existing buffers"})
  local function _2_()
    return builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({winblend = 10, previewer = false}))
  end
  vim.keymap.set("n", "<leader>/", _2_, {desc = "[/] Fuzzily search in current buffer"})
  local function _3_()
    return builtin.live_grep({grep_open_files = true, prompt_title = "Live Grep in Open Files"})
  end
  vim.keymap.set("n", "<leader>s/", _3_, {desc = "[S]earch [/] in Open Files"})
  local function _4_()
    return builtin.find_files({cwd = vim.fn.stdpath("config")})
  end
  return vim.keymap.set("n", "<leader>sn", _4_, {desc = "[S]earch [N]eovim files"})
end
local function _5_()
  return (vim.fn.executable("make") == 1)
end
return {uu.tx("nvim-telescope/telescope.nvim", {branch = "0.1.x", config = _1_, dependencies = {"nvim-lua/plenary.nvim", uu.tx("nvim-telescope/telescope-dap.nvim", {lazy = true}), {"nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = _5_}, {"nvim-telescope/telescope-ui-select.nvim"}, {"nvim-tree/nvim-web-devicons"}}, event = "VimEnter"})}
