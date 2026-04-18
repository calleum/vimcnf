-- [nfnl] fnl/cal/plugin/treesitter.fnl
local uu = require("cal.util")
local function _1_(_, opts)
  require("nvim-treesitter.install")["prefer_git"] = true
  local ts = require("nvim-treesitter")
  ts.setup(opts)
  if opts.ensure_installed then
    ts.install(opts.ensure_installed)
  else
  end
  local function _3_(args)
    local bufnr = args.buf
    local ft = vim.api.nvim_get_option_value("filetype", {buf = bufnr})
    local lang = vim.treesitter.language.get_lang(ft)
    if (lang and pcall(vim.treesitter.start, bufnr, lang)) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      return nil
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _3_, group = vim.api.nvim_create_augroup("treesitter-setup", {clear = true})})
end
local function _5_(_, opts)
  return require("treesitter-context").setup(opts)
end
local function _6_(buf)
  return (vim.bo[buf].filetype ~= "markdown")
end
return {uu.tx("nvim-treesitter/nvim-treesitter", {branch = "main", build = ":TSUpdate", config = _1_, opts = {auto_install = true, ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "javascript", "typescript", "vim", "vimdoc"}}}), uu.tx("nvim-treesitter/nvim-treesitter-context", {config = _5_, opts = {exclude_ftypes = {"markdown"}, on_attach = _6_}})}
