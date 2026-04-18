-- [nfnl] fnl/cal/init.fnl
local vim = _G.vim
local uu = require("cal.util")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
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
vim.opt.relativenumber = true
vim.opt.listchars = {nbsp = "\226\144\163", tab = "\194\187 ", trail = "\194\183"}
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.o.exrc = true
vim.o.secure = true
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.g.guicursor = ""
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
  return vim.fn.setreg("+", vim.fn.expand("%:p"))
end
vim.keymap.set("n", "<leader>cp", _1_)
vim.keymap.set("n", "n", "nzz", {noremap = true, silent = true})
vim.keymap.set("n", "N", "Nzz", {noremap = true, silent = true})
vim.keymap.set("n", "*", "*zz", {noremap = true, silent = true})
vim.keymap.set("n", "#", "#zz", {noremap = true, silent = true})
vim.keymap.set("n", "g*", "g*zz", {noremap = true, silent = true})
vim.keymap.set("n", "/", "/\\v", {noremap = true})
local function _2_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _2_, desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true})})
local function _3_(_, _0, _1, _2, metadata)
  metadata["injection.language"] = "yaml"
  return nil
end
vim.treesitter.query.add_directive("inject-go-tmpl!", _3_, {})
vim.filetype.add({pattern = {[".*helm/.*/.*/templates/.*%.tpl"] = "helm", [".*helm/.*/.*/templates/.*%.ya?ml"] = "helm", [".*chart/.*/templates/.*%.ya?ml"] = "helm", ["helmfile.*%.ya?ml"] = "helm"}, extension = {yml = "yaml", nft = "nftables"}})
local function _4_()
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 72
  vim.opt_local.colorcolumn = "73"
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "gitcommit", callback = _4_})
local function _5_()
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 80
  vim.opt_local.colorcolumn = "81"
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "tex", callback = _5_})
local function _6_()
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 90
  vim.opt_local.colorcolumn = "90"
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "text", callback = _6_})
local function _7_()
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 90
  vim.opt_local.colorcolumn = "90"
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", callback = _7_})
local function _8_()
  vim.bo.filetype = "mail"
  return nil
end
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {pattern = "/tmp/mutt*", callback = _8_})
local function _9_()
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 72
  vim.opt_local.colorcolumn = "73"
  vim.opt_local.formatoptions = (vim.opt_local.formatoptions._value .. "w")
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = "mail", callback = _9_})
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
else
end
vim.opt.rtp:prepend(lazypath)
local function _11_()
  vim.cmd.colorscheme("tokyonight-night")
  vim.cmd.hi("Comment gui=none")
  vim.api.nvim_set_hl(0, "TermCursor", {bg = "NONE", fg = "NONE"})
  return vim.api.nvim_set_hl(0, "TermCursorNC", {bg = "NONE", fg = "NONE"})
end
return require("lazy").setup({uu.tx("folke/todo-comments.nvim", {dependencies = {"nvim-lua/plenary.nvim"}, opts = {}}), uu.tx("tpope/vim-sleuth"), uu.tx("tpope/vim-fugitive"), uu.tx("tpope/vim-abolish"), uu.tx("Olical/nfnl"), uu.tx("isobit/vim-caddyfile"), uu.tx("numToStr/Comment.nvim", {opts = {}}), uu.tx("folke/tokyonight.nvim", {init = _11_, priority = 1000}), {import = "cal.plugin"}}, {dev = {path = "~/src/calleum", patterns = {"calleum"}, fallback = true}, rocks = {enabled = false}})
