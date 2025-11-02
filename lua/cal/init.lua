-- [nfnl] fnl/cal/init.fnl
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
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {callback = _1_, desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true})})
local function _2_()
  if (vim.bo.filetype == "java") then
    return vim.cmd("%s/\\s\\+$//e")
  else
    return nil
  end
end
vim.api.nvim_create_autocmd("BufWritePre", {callback = _2_, pattern = "*"})
vim.cmd("autocmd BufNewFile,BufRead *.jenkinsfile set filetype=groovy")
local function _4_(metadata)
  metadata["injection.language"] = "yaml"
  return nil
end
vim.treesitter.query.add_directive("inject-go-tmpl!", _4_, {})
vim.treesitter.language.register("xml", "jelly")
vim.filetype.add({pattern = {[".*helm/.*/.*/templates/.*%.tpl"] = "helm", [".*helm/.*/.*/templates/.*%.ya?ml"] = "helm", [".*chart/.*/templates/.*%.ya?ml"] = "helm", ["helmfile.*%.ya?ml"] = "helm"}, extension = {yml = "yaml", jelly = "jelly"}})
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
else
end
vim.opt.rtp:prepend(lazypath)
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _6_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_6_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function _8_()
  vim.cmd.colorscheme("tokyonight-night")
  return vim.cmd.hi("Comment gui=none")
end
local function _9_()
  return require("lsp-notify").setup({notify = require("notify")})
end
require("lazy").setup({tx("folke/todo-comments.nvim", {dependencies = {"nvim-lua/plenary.nvim"}, opts = {}}), tx("tpope/vim-sleuth"), tx("tpope/vim-fugitive"), tx("tpope/vim-abolish"), tx("tpope/vim-surround"), tx("Olical/nfnl"), tx("mrcjkb/nvim-lastplace"), tx("isobit/vim-caddyfile"), tx("numToStr/Comment.nvim", {opts = {}}), tx("folke/tokyonight.nvim", {init = _8_, priority = 1000}), tx("rcarriga/nvim-notify"), tx("mrded/nvim-lsp-notify", {config = _9_}), tx("ckipp01/nvim-jenkinsfile-linter", {ft = {"jenkinsfile", "groovy"}}), {import = "cal.plugin"}}, {dev = {path = "~/src/calleum", patterns = {"calleum"}, fallback = true}})
return vim.api.nvim_set_hl(0, "@jsni.java_call", {link = "Function"})
