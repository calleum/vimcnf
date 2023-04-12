--
-- Telescope

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('dap')
require('telescope').setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    },
    defaults = {
        mappings = {
            i = {
                -- ['<C-u>'] = false,
                -- ['<C-d>'] = false,
                -- ["<esc>"] = actions.close
            }
        }
    }
}
--
-- telescope-config.lua
local M = {}

M.project_files = function(opts)

    local ok = pcall(require 'telescope.builtin'.git_files, opts)
    if opts == nil then
        opts = {
            shorten_path = true,
            cwd = vim.fn.getenv 'PWD'
        }
    end
    if not ok then require 'telescope.builtin'.find_files(opts) end
end

M.grep = function (opts)
        if opts == nil then
        opts = {
            shorten_path = true,
            cwd = vim.fn.getenv 'PWD'
        }
    end
    require 'telescope.builtin'.grep_string(opts)
end

M.live_grep = function (opts)
        if opts == nil then
        opts = {
            shorten_path = true,
            cwd = vim.fn.getenv 'PWD'
        }
    end
    require 'telescope.builtin'.live_grep(opts)
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd([[!git log ]] .. selection[1])
    end)
    return true
end

M.git_log = function()
    -- example for running a command on a file
    local opts = {
        attach_mappings = run_selection
    }
    require('telescope.builtin').find_files(opts)
end

-- call via:
-- :lua require'telescope-config'.project_files()

-- example keymap:
-- vim.api.nvim_set_keymap('n', '<Leader><Space>', '<CMD>lua require\'telescope-config\'.project_files()<CR>', {noremap = true, silent = true})

function M.find_sametype()
    local myFiletype = vim.fn.expand('%:e')
    local opts = {
        prompt_title = "[Find in same filetype: " .. myFiletype .. "]",
        shorten_path = false,
        layout_strategy = "horizontal",
        find_command = { "fd", "--type", "f", "-e", myFiletype, "--strip-cwd-prefix" }
    }
    require 'telescope.builtin'.find_files(opts)
end

function M.protecht_find()
    local opts = {
        prompt_title = "[Find In ~/Documents/protecht]",
        shorten_path = true,
        cwd = "~/Documents/protecht/",
        layout_strategy = "horizontal",
    }
    require 'telescope.builtin'.find_files(opts)
end

function M.aws_jenkins_find()
    local opts = {
        prompt_title = "[Find In ~/src/uni]",
        shorten_path = false,
        cwd = "~/src/uni/",
        layout_strategy = "horizontal",
    }
    M.project_files(opts)
end

function M.aws_infra_find()
    local opts = {
        prompt_title = "~ aws-infra ~",
        shorten_path = false,
        cwd = "~/Documents/protecht/aws-infrastructure/",
        layout_strategy = "horizontal",
    }
    M.project_files(opts)
end

function M.dev_files_find()
    local opts = {
        prompt_title = "[Find In ~/src]",
        shorten_path = false,
        cwd = "~/src/",
        layout_strategy = "horizontal",
    }
    M.project_files(opts)
end

function M.config_find()
    local opts = {
        prompt_title = "[Find In ~/.config/nvim/]",
        shorten_path = false,
        cwd = "~/.config/nvim/",
        layout_strategy = "horizontal",
    }
    M.project_files(opts)
end

function M.notes_find()
    local opts = {
        prompt_title = "[Find In ~/src/notes]",
        shorten_path = false,
        cwd = "~/src/notes/",
        layout_strategy = "horizontal",
        sorting_strategy = "ascending"
    }
    M.project_files(opts)
end

return M
