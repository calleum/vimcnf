-- [nfnl] fnl/cal/plugin/lspconfig.fnl
local uu = require("cal.util")
local function set_lsp_keymaps(bufnr)
  local builtin = require("telescope.builtin")
  local maps
  local function _1_()
    return builtin.lsp_references({path_display = {"truncate"}, fname_width = 60})
  end
  local function _2_()
    return vim.lsp.buf.code_action({apply = true, context = {only = {"source.organizeImports"}}})
  end
  maps = {{"gd", builtin.lsp_definitions, "Goto Definition"}, {"gr", _1_, "Goto References"}, {"gI", builtin.lsp_implementations, "Goto Implementation"}, {"<leader>D", builtin.lsp_type_definitions, "Type Definition"}, {"<leader>ds", builtin.lsp_document_symbols, "Document Symbols"}, {"<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols"}, {"<leader>rn", vim.lsp.buf.rename, "Rename"}, {"<leader>ca", vim.lsp.buf.code_action, "Code Action"}, {"K", vim.lsp.buf.hover, "Hover Documentation"}, {"gD", vim.lsp.buf.declaration, "Goto Declaration"}, {"<leader>oi", _2_, "Organize Imports"}}
  for _, _3_ in ipairs(maps) do
    local lhs = _3_[1]
    local rhs = _3_[2]
    local desc = _3_[3]
    vim.keymap.set("n", lhs, rhs, {buffer = bufnr, desc = ("LSP: " .. desc)})
  end
  return nil
end
local function setup_lsp_highlights(bufnr, client)
  if (client and client.server_capabilities.documentHighlightProvider) then
    local group = vim.api.nvim_create_augroup("lsp-highlight", {clear = false})
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = bufnr, callback = vim.lsp.buf.document_highlight, group = group})
    vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {buffer = bufnr, callback = vim.lsp.buf.clear_references, group = group})
    local function _4_(event2)
      vim.lsp.buf.clear_references()
      return vim.api.nvim_clear_autocmds({buffer = event2.buf, group = group})
    end
    return vim.api.nvim_create_autocmd("LspDetach", {callback = _4_, group = vim.api.nvim_create_augroup("lsp-detach", {clear = true})})
  else
    return nil
  end
end
local function setup_lsp_inlay_hints(bufnr, client)
  if (client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint) then
    local function _6_()
      return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
    return vim.keymap.set("n", "<leader>th", _6_, {buffer = bufnr, desc = "LSP: Toggle Inlay Hints"})
  else
    return nil
  end
end
local function on_lsp_attach(_8_)
  local bufnr = _8_.buf
  local data = _8_.data
  local client = vim.lsp.get_client_by_id(data.client_id)
  set_lsp_keymaps(bufnr)
  setup_lsp_highlights(bufnr, client)
  return setup_lsp_inlay_hints(bufnr, client)
end
local function setup_lsp_attach_autocmd()
  return vim.api.nvim_create_autocmd("LspAttach", {callback = on_lsp_attach, group = vim.api.nvim_create_augroup("lsp-attach", {clear = true})})
end
local function get_server_config()
  local mason = {fish_lsp = {}, basedpyright = {}, lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}}
  local system = {["rust-analyzer"] = {}, fennel_language_server = {root_dir = require("lspconfig").util.root_pattern(".nfnl.fnl", "fnl", ".git"), settings = {fennel = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}}}
  return {mason = mason, system = system, all = vim.tbl_deep_extend("force", mason, system)}
end
local function setup_vtsls()
  local mason_path = vim.fn.expand("$MASON/packages")
  local vue_plugin = {name = "@vue/typescript-plugin", location = (mason_path .. "/vue-language-server/node_modules/@vue/language-server"), languages = {"vue"}, configNamespace = "typescript"}
  local configs = {vtsls = {filetypes = {"typescript", "javascript", "javascriptreact", "typescriptreact", "vue"}, settings = {vtsls = {tsserver = {globalPlugins = {vue_plugin}}}}}, vue_ls = {}}
  for name, cfg in pairs(configs) do
    vim.lsp.config(name, cfg)
  end
  return vim.tbl_keys(configs)
end
local function setup_mason(mason_servers)
  require("mason").setup()
  local ensure_installed = vim.tbl_keys(mason_servers)
  table.insert(ensure_installed, "stylua")
  return require("mason-tool-installer").setup({ensure_installed = ensure_installed})
end
local function _9_()
  setup_lsp_attach_autocmd()
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  local _let_10_ = get_server_config()
  local mason = _let_10_.mason
  local all_servers = _let_10_.all
  local extra_names = setup_vtsls()
  setup_mason(mason)
  local function _11_(name)
    local opts = (all_servers[name] or {})
    opts.capabilities = vim.tbl_deep_extend("force", (opts.capabilities or {}), capabilities)
    vim.notify(("LSP Setup: " .. name))
    return require("lspconfig")[name].setup(opts)
  end
  require("mason-lspconfig").setup({handlers = {_11_}})
  local to_enable = vim.tbl_keys(all_servers)
  vim.list_extend(to_enable, extra_names)
  return vim.lsp.enable(to_enable)
end
return {uu.tx("neovim/nvim-lspconfig", {config = _9_, dependencies = {{"williamboman/mason.nvim", config = true}, "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", {"folke/lazydev.nvim", opts = {}}, "saghen/blink.cmp"}})}
