local _2afile_2a = "/Users/calleum.pecqueux/.config/nvim/fnl/cal/plugin/conform.fnl"
local function _1_()
  return (require("conform")).format({async = true, lsp_format = "fallback"})
end
local function _2_(bufnr)
  local disable_filetypes = {c = true, cpp = true}
  return {lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype], timeout_ms = 500}
end
return {"stevearc/conform.nvim", keys = {{"<leader>f", _1_, desc = "[F]ormat buffer", mode = ""}}, opts = {format_on_save = _2_, formatters_by_ft = {lua = {"stylua"}, markdown = {"markdownlint", "markdown-toc"}, json = {"jq"}, fennel = {"fnlfmt"}, nix = {"nixfmt"}, python = {"black"}, groovy = {"npm-groovy-lint"}}, notify_on_error = false}, lazy = false}