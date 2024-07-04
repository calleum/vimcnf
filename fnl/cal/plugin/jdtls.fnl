(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))
(local a (uu.autoload :aniseed.core))
(local vim _G.vim)

(local java-cmds (vim.api.nvim_create_augroup :java_cmds {:clear true}))

(fn map [from to opts]
  (uu.remap from to opts))

(local project-name (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
(local java-share-dir (.. (vim.fn.getenv :HOME) :/.local/share/java/))
(local java-home (.. (vim.fn.getenv :HOME) :/.sdkman/candidates/java))
(local java-bin (.. java-home :/current/bin/java))
(local java-17 (.. java-home :/17.0.10-graal))
(local java-11 (.. java-home :/11.0.17-amzn))
(local workspace-dir (.. java-share-dir :workspace/ project-name))
(local bundles
       [(vim.fn.glob (.. java-share-dir
                         :java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar))])

(vim.list_extend bundles (vim.split (vim.fn.glob (.. java-share-dir
                                                     :vscode-java-test/server/*.jar))
                                    "\n"))

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     (vim.tbl_deep_extend :force capabilities
                          ((. (require :cmp_nvim_lsp) :default_capabilities))))

(local launcher-jar
       (vim.fn.glob (.. java-share-dir
                        :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1*.jar)))

(local config-dir
       (vim.fn.glob (.. java-share-dir
                        :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac_arm)))

(local java-agent (.. java-share-dir :lombok.jar))
[(uu.tx :mfussenegger/nvim-jdtls
        {:config (fn [_ opts]
                   (vim.api.nvim_create_autocmd :Filetype
                                                {:callback (fn []
                                                             (print opts.root_dir)
                                                             (if (and opts.root_dir
                                                                      (not= opts.root_dir
                                                                            ""))
                                                                 ((. (require :jdtls)
                                                                     :start_or_attach) opts)))
                                                 :pattern :java})
                   (vim.api.nvim_create_autocmd :LspAttach
                                                {:callback (fn [args]
                                                             (print :in_lspattach_callback)
                                                             (local client
                                                                    (vim.lsp.get_client_by_id args.data.client_id))
                                                             (when (= client.name
                                                                      :jdtls)
                                                               ((. (require :jdtls.dap)
                                                                   :setup_dap_main_class_configs))))
                                                 :pattern :*.java}))
         :dependencies [(uu.tx :mfussenegger/nvim-dap
                               {:dependencies [(uu.tx :williamboman/mason.nvim
                                                      {:opts {:ensure_installed [:java-debug-adapter
                                                                                 :java-test]}})]})
                        :williamboman/mason-lspconfig.nvim
                        :folke/which-key.nvim]
         :ft [:java]
         :lazy true
         :opts (fn [_ opts]
                 (a.merge! opts
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
                            :init_options {:jvm_args (.. "-javaagent:"
                                                         java-agent)
                                           :bundles ((. (require :nvim-jdtls-bundles)
                                                        :bundles))}
                            :on_attach (fn [_ bufnr] ; ((. (require :cal.keymap) :on_attach) _ bufnr)
                                         (print (.. :in_on_attach_ bufnr))

                                         (fn map [keys func desc]
                                           (vim.keymap.set :n keys func
                                                           {:buffer bufnr
                                                            :desc (.. "JDTLS: "
                                                                      desc)}))

                                         (local jdtls (require :jdtls))
                                         (jdtls.setup_dap {:hotcodereplace :auto})
                                         (jdtls.setup.add_commands)
                                         (local opts
                                                {:buffer bufnr :silent true})
                                         (map :<leader>b
                                              (fn []
                                                ((. (require :jdtls) :compile) :full))
                                              {:desc "[B]uild jdtls project"})
                                         (map :<leader>da
                                              (. (require :jdtls.dap)
                                                 :setup_dap_main_class_configs)
                                              opts)
                                         (map :<leader>ta jdtls.test_class opts)
                                         (map :gd
                                              (. (require :telescope.builtin)
                                                 :lsp_definitions)
                                              "[G]oto [D]efinition")
                                         (map :gr
                                              (. (require :telescope.builtin)
                                                 :lsp_references)
                                              "[G]oto [R]eferences")
                                         (map :gI
                                              (. (require :telescope.builtin)
                                                 :lsp_implementations)
                                              "[G]oto [I]mplementation")
                                         (map :<leader>D
                                              (. (require :telescope.builtin)
                                                 :lsp_type_definitions)
                                              "Type [D]efinition")
                                         (map :<leader>ds
                                              (. (require :telescope.builtin)
                                                 :lsp_document_symbols)
                                              "[D]ocument [S]ymbols")
                                         (map :<leader>ws
                                              (. (require :telescope.builtin)
                                                 :lsp_dynamic_workspace_symbols)
                                              "[W]orkspace [S]ymbols")
                                         (map :<leader>rn vim.lsp.buf.rename
                                              "[R]e[n]ame")
                                         (map :<leader>ca
                                              vim.lsp.buf.code_action
                                              "[C]ode [A]ction")
                                         (map :K vim.lsp.buf.hover
                                              "Hover Documentation")
                                         (map :gD vim.lsp.buf.declaration
                                              "[G]oto [D]eclaration")
                                         (map :<leader>tm
                                              jdtls.test_nearest_method opts)
                                         (map :<leader>tb
                                              (. (require :dap)
                                                 :toggle_breakpoint)
                                              opts)
                                         (map :<leader>tr
                                              (. (. (require :dap) :repl) :open)
                                              opts)
                                         (map :<leader>to
                                              (. (. (. (require :telescope)
                                                       :extensions)
                                                    :dap)
                                                 :commands)
                                              opts)
                                         (map :<leader>tt
                                              (. (require :dapui) :toggle) opts)
                                         (map :<A-o> jdtls.organize_imports
                                              opts)
                                         (nvim.set_keymap :v :crm
                                                          (. (jdtls.test_class)
                                                             [true])
                                                          opts))
                            :root_dir (vim.fs.root 0 [:.git])
                            :settings {:completion {:favoriteStaticMembers [:org.hamcrest.MatcherAssert.assertThat
                                                                            :org.hamcrest.Matchers.*
                                                                            :org.hamcrest.CoreMatchers.*
                                                                            :org.junit.jupiter.api.Assertions.*
                                                                            :java.util.Objects.requireNonNull
                                                                            :java.util.Objects.requireNonNullElse
                                                                            :org.mockito.Mockito.*]}
                                       :java {:configuration {:updateBuildConfiguration :interactive}
                                              :eclipse {:downloadSources true}
                                              :implementationsCodeLens {:enabled true}
                                              :maven {:downloadSources true
                                                      :updateSnapshots false}
                                              :runtimes [{:name :JavaSE-17
                                                          :path java-17}
                                                         {:name :JavaSE-11
                                                          :path java-11}]}
                                       :referencesCodeLens {:enabled true}}
                            :signatureHelp {:enabled true}
                            :sources {:organizeImports {:starThreshold 9999
                                                        :staticStarThreshold 9999}}
                            :format {:settings {:url (.. java-share-dir
                                                         :codestyle.xml)}}}))})]
