-- [nfnl] Compiled from fnl/cal/plugin/conform.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("conform")).format({async = true, lsp_format = "prefer"})
end
local function _2_(bufnr)
  local disable_filetypes = {c = true, cpp = true}
  return {lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype], timeout_ms = 500}
end
return {"stevearc/conform.nvim", keys = {{"<leader>f", _1_, desc = "[F]ormat buffer", mode = ""}}, opts = {format_on_save = _2_, formatters_by_ft = {lua = {"stylua"}, markdown = {"markdownlint", "markdown-toc"}, yaml = {"yamlfmt", "yamlfix"}, fennel = {"fnlfmt"}}, notify_on_error = false}, lazy = false}
