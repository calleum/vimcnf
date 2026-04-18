-- [nfnl] fnl/cal/plugin/lspconfig.fnl
local vim = _G.vim
local uu = require("cal.util")
local function _1_()
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
  local blink = require("blink.cmp")
  local capabilities = blink.get_lsp_capabilities()
  local mason_servers = {fish_lsp = {}, basedpyright = {}, lua_ls = {settings = {Lua = {completion = {callSnippet = "Replace"}}}}}
  local system_servers = {["rust-analyzer"] = {}, fennel_language_server = {}}
  local servers = vim.tbl_deep_extend("force", mason_servers, system_servers)
  local ensure_installed = vim.tbl_keys(mason_servers)
  vim.list_extend(ensure_installed, {"stylua"})
  local mason_path = vim.fn.expand("$MASON/packages")
  local vue_language_server_path = (mason_path .. "/vue-language-server/node_modules/@vue/language-server")
  local vue_plugin = {name = "@vue/typescript-plugin", location = vue_language_server_path, languages = {"vue"}, configNamespace = "typescript"}
  local tsserver_filetypes = {"typescript", "javascript", "javascriptreact", "typescriptreact", "vue"}
  local vtsls_config = {filetypes = tsserver_filetypes, settings = {vtsls = {tsserver = {globalPlugins = {vue_plugin}}}}}
  local vue_ls_config = {}
  vim.lsp.config("vtsls", vtsls_config)
  vim.lsp.config("vue_ls", vue_ls_config)
  local function view(list)
    local _9_
    do
      local tbl_26_ = {}
      local i_27_ = 0
      for _, val in ipairs(list) do
        local val_28_ = ("[" .. val .. "]")
        if (nil ~= val_28_) then
          i_27_ = (i_27_ + 1)
          tbl_26_[i_27_] = val_28_
        else
        end
      end
      _9_ = tbl_26_
    end
    return table.concat(_9_, " | ")
  end
  require("mason").setup()
  require("mason-tool-installer").setup({ensure_installed = ensure_installed})
  local function _11_(server_name)
    local server_opts = (servers[server_name] or {})
    server_opts.capabilities = vim.tbl_deep_extend("force", (server_opts.capabilities or {}), capabilities)
    vim.notify(view(server_name))
    return require("lspconfig")[server_name].setup(server_opts)
  end
  require("mason-lspconfig").setup({handlers = {_11_}})
  local all_servers_to_enable = vim.tbl_keys(servers)
  vim.list_extend(all_servers_to_enable, {"vtsls", "vue_ls"})
  vim.notify(view(all_servers_to_enable))
  return vim.lsp.enable(all_servers_to_enable)
end
return {uu.tx("neovim/nvim-lspconfig", {config = _1_, dependencies = {{"williamboman/mason.nvim", config = true}, "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", {"folke/lazydev.nvim", opts = {}}, "saghen/blink.cmp"}})}
