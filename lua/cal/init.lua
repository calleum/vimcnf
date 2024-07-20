-- [nfnl] Compiled from fnl/cal/init.fnl by https://github.com/Olical/nfnl, do not edit.
local vim = _G.vim
local fun = require("cal.util.vendor.fun")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {nbsp = "\226\144\163", tab = "\194\187 ", trail = "\194\183"}
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {desc = "Go to previous [D]iagnostic message"})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {desc = "Go to next [D]iagnostic message"})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {desc = "Show diagnostic [E]rror messages"})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {desc = "Open diagnostic [Q]uickfix list"})
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc = "Move focus to the left window"})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc = "Move focus to the right window"})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {desc = "Move focus to the lower window"})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {desc = "Move focus to the upper window"})
local function _1_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _1_, desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true})})
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
else
end
do end (vim.opt.rtp):prepend(lazypath)
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _3_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_3_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function _5_()
  vim.cmd.colorscheme("tokyonight-night")
  return vim.cmd.hi("Comment gui=none")
end
local function _6_()
  do end (require("mini.ai")).setup({n_lines = 500})
  do end (require("mini.surround")).setup()
  local statusline = require("mini.statusline")
  statusline.setup({use_icons = vim.g.have_nerd_font})
  local function _7_()
    return "%2l:%-2v"
  end
  statusline.section_location = _7_
  return nil
end
return (require("lazy")).setup({tx("tpope/vim-sleuth"), tx("tpope/vim-fugitive"), tx("tpope/vim-abolish"), tx("tpope/vim-surround"), tx("Olical/nfnl"), tx("Olical/aniseed"), tx("mrcjkb/nvim-lastplace"), tx("creativecreature/pulse"), tx("numToStr/Comment.nvim", {opts = {}}), tx("folke/tokyonight.nvim", {init = _5_, priority = 1000}), tx("folke/todo-comments.nvim", {dependencies = {"nvim-lua/plenary.nvim"}, event = "VimEnter", opts = {signs = false}}), tx("calleum/nvim-jdtls-bundles", {build = "./install-bundles.py", dependencies = {"nvim-lua/plenary.nvim"}}), tx("echasnovski/mini.nvim", {config = _6_}), {import = "cal.plugin"}})
