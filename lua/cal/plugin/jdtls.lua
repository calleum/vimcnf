-- [nfnl] Compiled from fnl/cal/plugin/jdtls.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("cal.util")
local vim = _G.vim
local java_cmds = vim.api.nvim_create_augroup("java_cmds", {clear = true})
local function map(from, to, opts)
  return uu.remap(from, to, opts)
end
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local java_share_dir = (vim.fn.getenv("HOME") .. "/.local/share/java/")
local java_home = (vim.fn.getenv("HOME") .. "/.sdkman/candidates/java")
local java_bin = (java_home .. "/current/bin/java")
local java_17 = (java_home .. "/17.0.10-graal")
local java_11 = (java_home .. "/11.0.17-amzn")
local workspace_dir = (java_share_dir .. "workspace/" .. project_name)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, (require("cmp_nvim_lsp")).default_capabilities())
local launcher_jar = vim.fn.glob((java_share_dir .. "eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1*.jar"))
local config_basename
if (vim.uv.os_uname().sysname == "Darwin") then
  config_basename = "config_mac_arm"
else
  config_basename = "config_linux"
end
local config_dir = vim.fn.glob((java_share_dir .. "eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/" .. config_basename))
local java_agent = (java_share_dir .. "lombok.jar")
local function setup_jdtls(opts)
  local function startup()
    local jdtls = require("jdtls")
    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    return jdtls.start_or_attach(opts)
  end
  local function _2_(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if (client.name == "jdtls") then
      do end (require("jdtls.dap")).setup_dap_main_class_configs()
      return nil
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("LspAttach", {callback = _2_, pattern = "*.java", group = java_cmds})
  local function check_autocmd_group()
    local autocmds = vim.api.nvim_get_autocmds({group = "java_cmds", event = "FileType"})
    if vim.tbl_isempty(autocmds) then
      return print("Autocommand group 'java_cmds' has been removed!")
    else
      return print("Autocommand group 'java_cmds' is still active.")
    end
  end
  local function _5_(event)
    if (opts.root_dir and (opts.root_dir ~= "")) then
      startup()
      return nil
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _5_, group = java_cmds, pattern = "java"})
end
local function on_attach(_, bufnr)
  local function map0(keys, func, desc)
    return vim.keymap.set("n", keys, func, {buffer = bufnr, desc = ("JDTLS: " .. desc)})
  end
  local function _7_()
    pcall(vim.lsp.codelens.refresh)
    return nil
  end
  vim.api.nvim_create_autocmd("BufWritePost", {buffer = bufnr, callback = _7_, desc = "refresh codelens", group = java_cmds})
  local jdtls = require("jdtls")
  jdtls.setup_dap({hotcodereplace = "auto"})
  jdtls.setup.add_commands()
  local function _8_()
    return (require("jdtls")).compile("full")
  end
  map0("<leader>b", _8_, "[B]uild jdtls project")
  map0("<leader>da", (require("jdtls.dap")).setup_dap_main_class_configs, "Setup [Da]p main class configs")
  map0("<leader>ta", jdtls.test_class, "[T]est [A]ll methods in file")
  map0("gd", (require("telescope.builtin")).lsp_definitions, "[G]oto [D]efinition")
  map0("gr", (require("telescope.builtin")).lsp_references, "[G]oto [R]eferences")
  map0("gi", (require("telescope.builtin")).lsp_implementations, "[G]oto [I]mplementation")
  map0("<leader>D", (require("telescope.builtin")).lsp_type_definitions, "Type [D]efinition")
  map0("<leader>ds", (require("telescope.builtin")).lsp_document_symbols, "[D]ocument [S]ymbols")
  map0("<leader>ws", (require("telescope.builtin")).lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  map0("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  map0("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  map0("K", vim.lsp.buf.hover, "Hover Documentation")
  map0("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map0("<leader>tm", jdtls.test_nearest_method, "[T]est nearest [M]ethod")
  map0("<leader>tb", (require("dap")).toggle_breakpoint, "[T]oggle [B]reakpoint")
  map0("<leader>tr", ((require("dap")).repl).open, "[T]oggle [R]epl")
  map0("<leader>to", (((require("telescope")).extensions).dap).commands, "[T]oggle telescope commands picker")
  map0("<leader>tt", (require("dapui")).toggle, "[T][T]oggle dap ui")
  return map0("<A-o>", jdtls.organize_imports, "Organize Imports")
end
local function configure(_, opts)
  local config = {capabilities = capabilities, cmd = {java_bin, "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", ("-javaagent:" .. java_agent), "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx4g", "--add-modules=ALL-SYSTEM", "--add-opens", "java.base/java.util=ALL-UNNAMED", "--add-opens", "java.base/java.lang=ALL-UNNAMED", "-jar", launcher_jar, "-configuration", config_dir, "-data", workspace_dir}, filetypes = {"java"}, init_options = {bundles = (require("nvim-jdtls-bundles")).bundles()}, on_attach = on_attach, root_dir = vim.fs.root(0, {".git"}), settings = {completion = {favoriteStaticMembers = {"org.hamcrest.MatcherAssert.assertThat", "org.hamcrest.Matchers.*", "org.hamcrest.CoreMatchers.*", "org.junit.jupiter.api.Assertions.*", "java.util.Objects.requireNonNull", "java.util.Objects.requireNonNullElse", "org.mockito.Mockito.*"}, importOrder = {"java", "javax", "org", "com", "\\#"}}, contentProvider = {preferred = "fernflower"}, java = {configuration = {runtimes = {{name = "JavaSE-17", path = java_17}, {name = "JavaSE-11", path = java_11}}, updateBuildConfiguration = "interactive"}, format = {settings = {url = (java_share_dir .. "codestyle.xml")}}, implementationsCodeLens = {enabled = true}, maven = {downloadSources = true, updateSnapshots = false}, referencesCodeLens = {enabled = true}, saveActions = {organizeImports = true}}, signatureHelp = {enabled = true}, sources = {organizeImports = {starThreshold = 9999, staticStarThreshold = 9999}}}}
  return setup_jdtls(config)
end
return {uu.tx("mfussenegger/nvim-jdtls", {config = configure, dependencies = {uu.tx("mfussenegger/nvim-dap")}, ft = {"java"}, lazy = true})}
