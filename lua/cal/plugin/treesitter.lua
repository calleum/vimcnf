-- [nfnl] fnl/cal/plugin/treesitter.fnl
local uu = require("cal.util")
local function setup_treesitter_highlights()
  local function _2_(_1_)
    local bufnr = _1_.buf
    local ft = vim.api.nvim_get_option_value("filetype", {buf = bufnr})
    local lang = vim.treesitter.language.get_lang(ft)
    if (lang and pcall(vim.treesitter.start, bufnr, lang)) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return nil
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _2_, group = vim.api.nvim_create_augroup("treesitter-setup", {clear = true})})
end
local function _4_(_, opts)
  require("nvim-treesitter.install")["prefer_git"] = true
  local ts = require("nvim-treesitter")
  ts.setup(opts)
  if opts.ensure_installed then
    ts.install(opts.ensure_installed)
  else
  end
  return setup_treesitter_highlights()
end
local function _6_(buf)
  return (vim.bo[buf].filetype ~= "markdown")
end
return {uu.tx("nvim-treesitter/nvim-treesitter", {branch = "main", build = ":TSUpdate", opts = {auto_install = true, ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "javascript", "typescript", "vim", "vimdoc"}}, config = _4_}), uu.tx("nvim-treesitter/nvim-treesitter-context", {opts = {exclude_ftypes = {"markdown"}, on_attach = _6_}})}
