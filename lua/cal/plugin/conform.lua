-- [nfnl] fnl/cal/plugin/conform.fnl
local uu = require("cal.util")
local function find_remove_unused_imports(actions)
  local found = nil
  for _, action in ipairs(actions) do
    if (not found and action.data and string.match((action.data.id or ""), "^remove_unused_imports")) then
      found = action
    else
    end
  end
  return found
end
local function rust_remove_unused_imports(bufnr)
  local _let_2_ = vim.lsp.get_clients({bufnr = bufnr, name = "rust_analyzer"})
  local client = _let_2_[1]
  if client then
    local last_line = math.max(0, (vim.api.nvim_buf_line_count(bufnr) - 1))
    local params = {textDocument = vim.lsp.util.make_text_document_params(bufnr), range = {start = {line = 0, character = 0}, ["end"] = {line = last_line, character = 0}}, context = {diagnostics = {}, only = {"quickfix"}}}
    local response = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
    local action
    local _4_
    do
      local t_3_ = response
      if (nil ~= t_3_) then
        t_3_ = t_3_.result
      else
      end
      _4_ = t_3_
    end
    action = find_remove_unused_imports((_4_ or {}))
    if action then
      local resolved
      local _7_
      do
        local t_6_ = client:request_sync("codeAction/resolve", action, 1000, bufnr)
        if (nil ~= t_6_) then
          t_6_ = t_6_.result
        else
        end
        _7_ = t_6_
      end
      resolved = (_7_ or action)
      if resolved.edit then
        return vim.lsp.util.apply_workspace_edit(resolved.edit, client.offset_encoding)
      else
        return nil
      end
    else
      return nil
    end
  else
    return nil
  end
end
local function organize_imports(bufnr)
  if (vim.bo[bufnr].filetype == "rust") then
    return rust_remove_unused_imports(bufnr)
  else
    return nil
  end
end
local function format_buffer()
  organize_imports(vim.api.nvim_get_current_buf())
  return require("conform").format({async = true, lsp_format = "fallback"})
end
local function format_on_save(bufnr)
  organize_imports(bufnr)
  return {lsp_format = "fallback", timeout_ms = 500}
end
return {uu.tx("stevearc/conform.nvim", {keys = {uu.tx("<leader>f", format_buffer, {desc = "[F]ormat buffer"})}, opts = {format_on_save = format_on_save, formatters_by_ft = {lua = {"stylua"}, rust = {"injected", "rustfmt"}, sql = {"sqlfmt"}, vue = {"eslint_d"}, make = {"bake"}, bash = {"shfmt"}, sh = {"shfmt"}, json = {"jq"}, latex = {"tex-fmt"}, fennel = {"fnlfmt"}, nix = {"nixfmt"}, python = {"black"}}}, lazy = false})}
