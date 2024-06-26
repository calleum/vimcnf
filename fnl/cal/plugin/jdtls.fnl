(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))
(local p (uu.autoload :cal.plugin))

(fn map [from to opts]
  (uu.remap from to opts))

(local project-name (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
(local java-share-dir (.. (vim.fn.getenv :HOME) :/.local/share/java/))
(local java-home (.. (vim.fn.getenv :HOME) :/.sdkman/candidates/java))
(local java-bin (.. java-home :/current/bin/java))
(local java-17 (.. java-home :/17.0.10-graal))
(local java-11 (.. java-home :/11.0.17-amzn))
(local workspace-dir (.. java-share-dir :workspace/ project-name))
(local jdtls (require :jdtls))
(local bundles
       [(vim.fn.glob (.. java-share-dir
                         :java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar))])

(vim.list_extend bundles (vim.split (vim.fn.glob (.. java-share-dir
                                                     :vscode-java-test/server/*.jar))
                                    "\n"))

(fn on-attach [_ bufnr] ; ((. (require :cal.keymap) :on_attach) _ bufnr)
  (local opts {:buffer bufnr :silent true})
  (map :<leader>b (fn []
                    ((. (require :jdtls) :compile) :full))
       {:desc "[B]uild jdtls project"})
  (map :<leader>da (. (require :jdtls.dap) :setup_dap_main_class_configs) opts)
  (map :<leader>ta jdtls.test_class opts)
  (map :<leader>tm jdtls.test_nearest_method opts)
  (map :<leader>tb (. (require :dap) :toggle_breakpoint) opts)
  (map :<leader>tr (. (. (require :dap) :repl) :open) opts)
  (map :<leader>to (. (. (. (require :telescope) :extensions) :dap) :commands)
       opts)
  (map :<leader>tt (. (require :dapui) :toggle) opts)
  (map :<A-o> jdtls.organize_imports opts)
  (nvim.set_keymap :v :crm
                   "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>"
                   opts) ; (jdtls.setup_dap {:hotcodereplace :auto})
  (jdtls.setup.add_commands))

(local capabilities
       ((. (require :cmp_nvim_lsp) :default_capabilities) (vim.lsp.protocol.make_client_capabilities)))

(local launcher-jar
       (vim.fn.glob (.. java-share-dir
                        :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1*.jar)))

(local config-dir
       (vim.fn.glob (.. java-share-dir
                        :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac_arm)))

(local java-agent (.. java-share-dir :lombok.jar))
(local config
       {: capabilities
        :cmd [java-bin
              :-Declipse.application=org.eclipse.jdt.ls.core.id1
              :-Dosgi.bundles.defaultStartLevel=4
              (.. "-javaagent:" java-agent)
              :-Declipse.product=org.eclipse.jdt.ls.core.product
              :-Dlog.protocol=true
              :-Dlog.level=ALL
              :-Xms1g
              :-Xmx4g
              :--add-modules=ALL-SYSTEM
              :--add-opens
              :java.base/java.util=ALL-UNNAMED
              :--add-opens
              :java.base/java.lang=ALL-UNNAMED
              :-jar
              launcher-jar
              :-configuration
              config-dir
              :-data
              workspace-dir]
        :filetypes [:java]
        :init_options {:bundles ((. (require :nvim-jdtls-bundles) :bundles))}
        :on_attach on-attach
        :root_dir ((. (require :jdtls.setup) :find_root) [:.git
                                                          :mvnw
                                                          :pom.xml
                                                          :gradlew])
        :settings {:java {:configuration {:runtimes [{:name :JavaSE-17
                                                      :path java-17}
                                                     {:name :JavaSE-11
                                                      :path java-11}]}
                          :format {:settings {:url (.. java-share-dir
                                                       :codestyle.xml)}}}}})

(. (p.req :dap))
; ((. (require :dapui) :setup))	
(nvim.echo "lang loaded")

{: config}
