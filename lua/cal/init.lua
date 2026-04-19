-- [nfnl] fnl/cal/init.fnl
local uu = require("cal.util")
local function setup_options()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.g.have_nerd_font = false
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  do
    local options = {number = true, mouse = "a", clipboard = "unnamedplus", breakindent = true, undofile = true, ignorecase = true, smartcase = true, signcolumn = "yes", updatetime = 250, timeoutlen = 300, splitright = true, splitbelow = true, list = true, relativenumber = true, listchars = {nbsp = "\226\144\163", tab = "\194\187 ", trail = "\194\183"}, inccommand = "split", cursorline = true, scrolloff = 10, hlsearch = true, showmode = false}
    for name, val in pairs(options) do
      vim.opt[name] = val
    end
  end
  vim.o.exrc = true
  vim.o.secure = true
  vim.opt.diffopt:append("algorithm:patience")
  vim.opt.diffopt:append("indent-heuristic")
  vim.g.guicursor = ""
  return nil
end
local function setup_keymaps()
  local maps
  local function _1_()
    return vim.fn.setreg("+", vim.fn.expand("%:p"))
  end
  maps = {{"n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight"}, {"n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic"}, {"n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic"}, {"n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic error"}, {"n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic quickfix"}, {"t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode"}, {"n", "<C-h>", "<C-w><C-h>", "Focus left window"}, {"n", "<C-l>", "<C-w><C-l>", "Focus right window"}, {"n", "<C-j>", "<C-w><C-j>", "Focus lower window"}, {"n", "<C-k>", "<C-w><C-k>", "Focus upper window"}, {"n", "<leader>cp", _1_, "Copy file path"}, {"n", "n", "nzz", "Center next search"}, {"n", "N", "Nzz", "Center prev search"}, {"n", "*", "*zz", "Center * search"}, {"n", "#", "#zz", "Center # search"}, {"n", "g*", "g*zz", "Center g* search"}, {"n", "/", "/\\v", "Search with very magic"}}
  for _, _2_ in ipairs(maps) do
    local mode = _2_[1]
    local lhs = _2_[2]
    local rhs = _2_[3]
    local desc = _2_[4]
    vim.keymap.set(mode, lhs, rhs, {desc = desc})
  end
  return nil
end
local function setup_autocommands()
  local function _3_()
    return vim.highlight.on_yank()
  end
  vim.api.nvim_create_autocmd("TextYankPost", {callback = _3_, desc = "Highlight when yanking text", group = vim.api.nvim_create_augroup("highlight-yank", {clear = true})})
  do
    local ft_configs = {{"gitcommit", 72, 73}, {"tex", 80, 81}, {"text", 90, 90}, {"markdown", 90, 90}}
    for _, _4_ in ipairs(ft_configs) do
      local ft = _4_[1]
      local tw = _4_[2]
      local cc = _4_[3]
      local function _5_()
        vim.opt_local.spell = true
        vim.opt_local.textwidth = tw
        vim.opt_local.colorcolumn = tostring(cc)
        return nil
      end
      vim.api.nvim_create_autocmd("FileType", {pattern = ft, callback = _5_})
    end
  end
  local function _6_()
    vim.bo.filetype = "mail"
    return nil
  end
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {pattern = "/tmp/mutt*", callback = _6_})
  local function _7_()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
    vim.opt_local.formatoptions = (vim.opt_local.formatoptions._value .. "w")
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = "mail", callback = _7_})
end
local function setup_lazy()
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath})
  else
  end
  vim.opt.rtp:prepend(lazypath)
  local lazy = require("lazy")
  local function _9_()
    vim.cmd.colorscheme("tokyonight-night")
    vim.cmd.hi("Comment gui=none")
    local clear = {bg = "NONE", fg = "NONE"}
    vim.api.nvim_set_hl(0, "TermCursor", clear)
    return vim.api.nvim_set_hl(0, "TermCursorNC", clear)
  end
  return lazy.setup({uu.tx("folke/todo-comments.nvim", {dependencies = {"nvim-lua/plenary.nvim"}, opts = {}}), uu.tx("tpope/vim-sleuth"), uu.tx("tpope/vim-fugitive"), uu.tx("tpope/vim-abolish"), uu.tx("Olical/nfnl"), uu.tx("isobit/vim-caddyfile"), uu.tx("numToStr/Comment.nvim", {opts = {}}), uu.tx("folke/tokyonight.nvim", {init = _9_, priority = 1000}), {import = "cal.plugin"}}, {dev = {path = "~/src/calleum", patterns = {"calleum"}, fallback = true}, rocks = {enabled = false}})
end
local function setup_treesitter_injects()
  local function _10_(_, _0, _1, _2, metadata)
    metadata.injection.language = "yaml"
    return nil
  end
  return vim.treesitter.query.add_directive("inject-go-tmpl!", _10_, {})
end
local function setup_filetypes()
  return vim.filetype.add({pattern = {[".*helm/.*/.*/templates/.*%.tpl"] = "helm", [".*helm/.*/.*/templates/.*%.ya?ml"] = "helm", [".*chart/.*/templates/.*%.ya?ml"] = "helm", ["helmfile.*%.ya?ml"] = "helm"}, extension = {yml = "yaml", nft = "nftables"}})
end
local function init()
  setup_options()
  setup_keymaps()
  setup_autocommands()
  setup_lazy()
  setup_treesitter_injects()
  return setup_filetypes()
end
return {init = init}
