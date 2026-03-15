-- [nfnl] fnl/cal/plugin/lspconfig.fnl
local vim = _G.vim
local uu = require("cal.util")
local function _1_()
  vim.lsp.set_log_level("ERROR")
  local function _2_(event)
    local function map(keys, func, desc)
      return vim.keymap.set("n", keys, func, {buffer = event.buf, desc = ("LSP: " .. desc)})
    end
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    local function _3_()
      return vim.lsp.buf.code_action({apply = true, context = {only = {"source.organizeImports"}}})
    end
    map("<leader>oi", _3_, "[O]rganize [I]mports")
    local function _4_()
      return require("telescope.builtin").lsp_references({path_display = {"truncate"}, fname_width = 60})
    end
    map("gr", _4_, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>lC", "<Cmd>Lspsaga outgoing_calls<CR>", "[l]oad outgoing [C]alls")
    map("<leader>lc", "<Cmd>Lspsaga incoming_calls<CR>", "[l]oad incoming [c]alls")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if (client and client.server_capabilities.documentHighlightProvider) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", {clear = false})
      vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = event.buf, callback = vim.lsp.buf.document_highlight, group = highlight_augroup})
      vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {buffer = event.buf, callback = vim.lsp.buf.clear_references, group = highlight_augroup})
      local function _5_(event2)
        vim.lsp.buf.clear_references()
        return vim.api.nvim_clear_autocmds({buffer = event2.buf, group = "kickstart-lsp-highlight"})
      end
      vim.api.nvim_create_autocmd("LspDetach", {callback = _5_, group = vim.api.nvim_create_augroup("kickstart-lsp-detach", {clear = true})})
    else
    end
    if ((client and client.server_capabilities.inlayHintProvider) and vim.lsp.inlay_hint) then
      local function _7_()
        return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
      return map("<leader>th", _7_, "[T]oggle Inlay [H]ints")
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("LspAttach", {callback = _2_, group = vim.api.nvim_create_augroup("kickstart-lsp-attach", {clear = true})})
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
  local servers = {fish_lsp = {}, basedpyright = {}, lemminx = {settings = {xml = {format = {joinCDATALines = true, enabled = false, splitAttributes = false}}}}, ["rust-analyzer"] = {}, lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}}
  require("mason").setup()
  local ensure_installed = vim.tbl_keys((servers or {}))
  vim.list_extend(ensure_installed, {"stylua"})
  local vue_language_server_path = (vim.fn.expand("$MASON/packages") .. "/vue-language-server" .. "/node_modules/@vue/language-server")
  local tsserver_filetypes = {"typescript", "javascript", "javascriptreact", "typescriptreact", "vue"}
  local vue_plugin = {configNamespace = "typescript", languages = {"vue"}, location = vue_language_server_path, name = "@vue/typescript-plugin"}
  local vtsls_config = {filetypes = tsserver_filetypes, settings = {vtsls = {tsserver = {globalPlugins = {vue_plugin}}}}}
  local ts_ls_config = {filetypes = tsserver_filetypes, init_options = {plugins = {vue_plugin}}}
  local vue_ls_config = {}
  vim.lsp.config("vtsls", vtsls_config)
  vim.lsp.config("vue_ls", vue_ls_config)
  vim.lsp.config("ts_ls", ts_ls_config)
  vim.lsp.enable({"vtsls", "vue_ls"})
  require("mason-tool-installer").setup({ensure_installed = ensure_installed})
  local function _9_(server_name)
    local server = (servers[server_name] or {})
    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, (server.capabilities or {}))
    return require("lspconfig")[server_name].setup(server)
  end
  return require("mason-lspconfig").setup({handlers = {_9_}})
end
return {uu.tx("neovim/nvim-lspconfig", {config = _1_, dependencies = {{"williamboman/mason.nvim", config = true}, "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", {"folke/neodev.nvim", opts = {}}}})}
