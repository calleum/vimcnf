-- [nfnl] fnl/cal/plugin/telescope.fnl
local uu = require("cal.util")
local function setup_telescope()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  telescope.setup({extensions = {["ui-select"] = {themes.get_dropdown({layout_config = {width = 0.9}})}}})
  for _, ext in ipairs({"fzf", "ui-select", "dap"}) do
    pcall(telescope.load_extension, ext)
  end
  return nil
end
local function set_telescope_keymaps()
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")
  local maps
  local function _1_()
    return builtin.current_buffer_fuzzy_find(themes.get_dropdown({winblend = 10, previewer = false}))
  end
  local function _2_()
    return builtin.live_grep({grep_open_files = true, prompt_title = "Live Grep in Open Files"})
  end
  local function _3_()
    return builtin.find_files({cwd = vim.fn.expand("~/.config/fish")})
  end
  local function _4_()
    return builtin.find_files({cwd = vim.fn.stdpath("config")})
  end
  maps = {{"<leader>sh", builtin.help_tags, "Search Help"}, {"<leader>sm", builtin.man_pages, "Search Man Pages"}, {"<leader>sk", builtin.keymaps, "Search Keymaps"}, {"<leader>sf", builtin.find_files, "Search Files"}, {"<leader>sw", builtin.grep_string, "Search current Word"}, {"<leader>sg", builtin.live_grep, "Search by Grep"}, {"<leader>sd", builtin.diagnostics, "Search Diagnostics"}, {"<leader>sr", builtin.resume, "Search References"}, {"<leader>s.", builtin.oldfiles, "Search Recent Files (\".\" for repeat)"}, {"<leader><leader>", builtin.buffers, "[ ] Find existing buffers"}, {"<leader>/", _1_, "[/] Fuzzily search in current buffer"}, {"<leader>s/", _2_, "Search [/] in Open Files"}, {"<leader>ss", _3_, "Search Fish files"}, {"<leader>sn", _4_, "Search Neovim files"}}
  for _, _5_ in ipairs(maps) do
    local lhs = _5_[1]
    local rhs = _5_[2]
    local desc = _5_[3]
    vim.keymap.set("n", lhs, rhs, {desc = desc})
  end
  return nil
end
local function _6_()
  setup_telescope()
  return set_telescope_keymaps()
end
local function _7_()
  return (vim.fn.executable("make") == 1)
end
return {uu.tx("nvim-telescope/telescope.nvim", {branch = "master", event = "VimEnter", config = _6_, dependencies = {"nvim-lua/plenary.nvim", uu.tx("nvim-telescope/telescope-dap.nvim", {lazy = true}), uu.tx("nvim-telescope/telescope-fzf-native.nvim", {build = "make", cond = _7_}), uu.tx("nvim-telescope/telescope-ui-select.nvim"), "nvim-tree/nvim-web-devicons"}})}
