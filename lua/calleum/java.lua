local M = {}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.getenv 'HOME' .. '/.local/share/java/workspace/' .. project_name
local jdtls = require('jdtls')
local bundles = { vim.fn.glob("/Users/calleum.pecqueux/Documents/protecht/dependencies/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"), };
vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/calleum.pecqueux/Documents/protecht/dependencies/vscode-java-test/server/*.jar"), "\n"))

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  require('calleum.lsp').on_attach(_, bufnr)
  vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, opts)
  vim.keymap.set('n', '<leader>tb', require'dap'.toggle_breakpoint, opts)
  vim.keymap.set('n', '<leader>tr', require'dap'.repl.open, opts)
  vim.keymap.set('n', '<leader>to', require'telescope'.extensions.dap.commands, opts)
  vim.keymap.set('n', '<leader>tt', require'dapui'.toggle, opts)
  vim.keymap.set('n', "ø", jdtls.organize_imports, opts)
  vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
  vim.keymap.set('n', '<leader>ta', jdtls.test_class, opts)
  jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()
end

local launcher_jar = vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.*/libexec/plugins/org.eclipse.equinox.launcher_1*.jar')
local config_dir = vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.*/libexec/config_mac/')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

M.setup = function()

  local config = {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "java" },
    cmd = {
      '/Users/calleum.pecqueux/.sdkman/candidates/java/17.0.4-amzn/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-javaagent:/Users/calleum.pecqueux/Documents/protecht/dependencies/lombok.jar',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '-Xmx8g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', launcher_jar,
      '-configuration', config_dir,
      '-data', workspace_dir
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'pom.xml', 'gradlew'}),
    settings = {
      java = {
        format = {
          settings = {
            url = '/Users/calleum.pecqueux/Documents/protecht/dependencies/codestyle.xml'
          }
        },
        configuration = {
          runtimes = {
            {
              name = "JavaSE-1.8",
              path = "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/",
            },
            {
              name = "JavaSE-17",
              path = "/Users/calleum.pecqueux/.sdkman/candidates/java/17.0.4-amzn/",
            },
            {
              name = "JavaSE-11",
              path = "/Users/calleum.pecqueux/.sdkman/candidates/java/11.0.15.9.1-amzn/",
            },
            {
              name = "JavaSE-18",
              path = "/Users/calleum.pecqueux/.sdkman/candidates/java/18.0.1-tem/",
            },
          }
        }
      }
    },
    init_options = {
      bundles = bundles, {
          }
    },
  }
  require('jdtls').start_or_attach(config)
  vim.o.expandtab = false
end

return M
