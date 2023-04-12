local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local java_share_dir = vim.fn.getenv 'HOME' .. '/.local/share/java/'
local workspace_dir = java_share_dir .. 'workspace/' .. project_name
local jdtls = require('jdtls')
local bundles = {
    vim.fn.glob(java_share_dir ..
                    "java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
};
vim.list_extend(bundles, vim.split(
                    vim.fn
                        .glob(java_share_dir .. "vscode-java-test/server/*.jar"),
                    "\n"))

local on_attach = function(_, bufnr)
    -- load in generic on_attach function
    require('calleum.keymap').on_attach(_, bufnr)

    local opts = {silent = true, buffer = bufnr}
    vim.keymap.set('n', '<leader>b',  function() require('jdtls').compile('full') end, { desc = '[B]uild jdtls project' })
    vim.keymap.set('n', '<leader>da',
                   require'jdtls.dap'.setup_dap_main_class_configs, opts)

    vim.keymap.set('n', '<leader>ta', jdtls.test_class, opts)
    vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, opts)
    vim.keymap.set('n', '<leader>tb', require'dap'.toggle_breakpoint, opts)
    vim.keymap.set('n', '<leader>tr', require'dap'.repl.open, opts)
    vim.keymap.set('n', '<leader>to',
                   require'telescope'.extensions.dap.commands, opts)
    vim.keymap.set('n', '<leader>tt', require'dapui'.toggle, opts)
    vim.keymap.set('n', "<A-o>",      jdtls.organize_imports, opts)
    vim.keymap.set('v', 'crm',
                   [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                   opts)
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    jdtls.setup.add_commands()
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local launcher_jar = vim.fn.glob(java_share_dir .. 'eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1*.jar')
local config_dir = vim.fn.glob(java_share_dir .. 'eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux/')
local java_agent = java_share_dir .. 'lombok.jar'
local config = {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {"java"},
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-javaagent:' .. java_agent,
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true', '-Dlog.level=ALL',
        '-Xms1g',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher_jar,
        '-configuration', config_dir,
        '-data', workspace_dir
    },
    root_dir = require('jdtls.setup').find_root({
        '.git', 'mvnw', 'pom.xml', 'gradlew'
    }),
    settings = {
        java = {
            format = {settings = {url = java_share_dir .. 'codestyle.xml'}},
            configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk/",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/",
          },

          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk/",
          },
        }
      }
        }
    },

    init_options = { bundles = require('nvim-jdtls-bundles').bundles() },
}
require('jdtls').start_or_attach(config)
require("dapui").setup()

