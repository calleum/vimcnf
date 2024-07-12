-- [nfnl] Compiled from fnl/cal/plugin/conf/tele-custom.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local function _1_(opts)
  local ok = pcall((require("telescope.builtin")).git_files, opts)
  if not ok then
    return (require("telescope.builtin")).find_files(opts)
  else
    return nil
  end
end
M.project_files = _1_
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local function run_selection(prompt_bufnr, map)
  local function _3_()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    return vim.cmd(("!git log " .. selection[1]))
  end
  do end (actions.select_default):replace(_3_)
  return true
end
local function _4_()
  local opts = {attach_mappings = run_selection}
  return (require("telescope.builtin")).find_files(opts)
end
M.git_log = _4_
M.find_sametype = function()
  local my_filetype = vim.fn.expand("%:e")
  local opts = {find_command = {"fd", "--type", "f", "-e", my_filetype, "--strip-cwd-prefix"}, layout_strategy = "horizontal", prompt_title = ("[Find in same filetype: " .. my_filetype .. "]"), shorten_path = false}
  return (require("telescope.builtin")).find_files(opts)
end
M.protecht_find = function()
  local opts = {cwd = "~/Documents/protecht/", layout_strategy = "horizontal", prompt_title = "[Find In ~/Documents/protecht]", shorten_path = true}
  return (require("telescope.builtin")).find_files(opts)
end
M.aws_jenkins_find = function()
  local opts = {cwd = "~/src/uni/", layout_strategy = "horizontal", prompt_title = "[Find In ~/src/uni]", shorten_path = false}
  return M.project_files(opts)
end
M.aws_infra_find = function()
  local opts = {cwd = "~/Documents/protecht/aws-infrastructure/", layout_strategy = "horizontal", prompt_title = "~ aws-infra ~", shorten_path = false}
  return M.project_files(opts)
end
M.dev_files_find = function()
  local opts = {cwd = "~/src/", layout_strategy = "horizontal", prompt_title = "[Find In ~/src]", shorten_path = false}
  return M.project_files(opts)
end
M.config_find = function()
  local opts = {cwd = "~/.config/nvim/", layout_strategy = "horizontal", prompt_title = "[Find In ~/.config/nvim/]", shorten_path = false}
  return M.project_files(opts)
end
M.notes_find = function()
  local opts = {cwd = "~/src/notes/", layout_strategy = "horizontal", prompt_title = "[Find In ~/src/notes]", sorting_strategy = "ascending", shorten_path = false}
  return M.project_files(opts)
end
return M
