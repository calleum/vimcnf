-- [nfnl] fnl/cal/plugin/conf/rust.fnl
local uu = require("cal.util")
local nvim = uu.autoload("aniseed.nvim")
local function map(from, to, opts)
  return uu.remap(from, to, opts)
end
local function remap(from, to, opts)
  local map_opts = {noremap = true}
  if a.get(opts, "local?") then
    return nvim.buf_set_keymap(0, "n", from, to, map_opts)
  else
    return nvim.set_keymap("n", from, to, map_opts)
  end
end
local ok_3f, rt = nil, nil
local function _2_()
  return require("rust-tools")
end
ok_3f, rt = pcall(_2_)
if ok_3f then
  local function rt_on_attach(_, bufnr)
    local opts = {buffer = bufnr}
    map("K", rt.hover_actions.hover_actions, opts)
    map("<Leader>a", rt.code_action_group.code_action_group, opts)
    map("<Leader>ru", rt.runnables.runnables, opts)
    return nil
  end
  local rt_opts = {server = {capabilities = require("cmp_nvim_lsp").default_capabilities(), on_attach = rt_on_attach, settings = {["rust-analyzer"] = {diagnostics = {enable = true, experimental = {enable = true}}}}, standalone = false}, tools = {inlay_hints = {disable = true, other_hints_prefix = "", parameter_hints_prefix = "", auto = false, show_parameter_hints = false}, runnables = {use_telescope = true}}}
  rt.setup(rt_opts)
  return rt.inlay_hints.disable()
else
  return nil
end
