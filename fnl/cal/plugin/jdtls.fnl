(local uu (require :cal.util))
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

(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     (vim.tbl_deep_extend :force capabilities
                          ((. (require :cmp_nvim_lsp) :default_capabilities))))

(local launcher-jar
       (vim.fn.glob (.. java-share-dir
                        :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1*.jar)))

(local config_basename (if (= (. (vim.uv.os_uname) :sysname) :Darwin)
                           :config_mac_arm
                           :config_linux))

(local config-dir (vim.fn.glob (.. java-share-dir
                                   :eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/
                                   config_basename)))

(local java-agent (.. java-share-dir :lombok.jar))
(fn setup_jdtls [opts]
  (fn startup []
    (local jdtls (require :jdtls))
    (set jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport
         true)
    (jdtls.start_or_attach opts))

  (vim.api.nvim_create_autocmd :LspAttach
                               {:callback (fn [event]
                                            (local client
                                                   (vim.lsp.get_client_by_id event.data.client_id))
                                            (when (= client.name :jdtls)
                                              ((. (require :jdtls.dap)
                                                  :setup_dap_main_class_configs))
                                              nil))
                                :pattern :*.java
                                :group java-cmds})

  (fn check-autocmd-group []
    (let [autocmds (vim.api.nvim_get_autocmds {:group :java_cmds
                                               :event :FileType})]
      (if (vim.tbl_isempty autocmds)
          (print "Autocommand group 'java_cmds' has been removed!")
          (print "Autocommand group 'java_cmds' is still active."))))

  (vim.api.nvim_create_autocmd :FileType
                               {:callback (fn [event]
                                            (when (and opts.root_dir
                                                       (not= opts.root_dir ""))
                                              (startup)
                                              nil))
                                :group java-cmds
                                :pattern :java}))

(fn on-attach [_ bufnr]
  (fn map [keys func desc]
    (vim.keymap.set :n keys func {:buffer bufnr :desc (.. "JDTLS: " desc)}))

  (vim.api.nvim_create_autocmd :BufWritePost
                               {:buffer bufnr
                                :callback (fn []
                                            (pcall vim.lsp.codelens.refresh)
                                            nil)
                                :desc "refresh codelens"
                                :group java-cmds})
  (local jdtls (require :jdtls))
  (jdtls.setup_dap {:hotcodereplace :auto})
  (jdtls.setup.add_commands)
  (map :<leader>b (fn []
                    ((. (require :jdtls) :compile) :full))
       "[B]uild jdtls project")
  (map :<leader>da (. (require :jdtls.dap) :setup_dap_main_class_configs)
       "Setup [Da]p main class configs")
  (map :<leader>ta jdtls.test_class "[T]est [A]ll methods in file")
  (map :gd (. (require :telescope.builtin) :lsp_definitions)
       "[G]oto [D]efinition")
  (map :gr (. (require :telescope.builtin) :lsp_references)
       "[G]oto [R]eferences")
  (map :gi (. (require :telescope.builtin) :lsp_implementations)
       "[G]oto [I]mplementation")
  (map :<leader>D (. (require :telescope.builtin) :lsp_type_definitions)
       "Type [D]efinition")
  (map :<leader>ds (. (require :telescope.builtin) :lsp_document_symbols)
       "[D]ocument [S]ymbols")
  (map :<leader>ws (. (require :telescope.builtin)
                      :lsp_dynamic_workspace_symbols)
       "[W]orkspace [S]ymbols")
  (map :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
  (map :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
  (map :K vim.lsp.buf.hover "Hover Documentation")
  (map :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (map :<leader>tm jdtls.test_nearest_method "[T]est nearest [M]ethod")
  (map :<leader>tb (. (require :dap) :toggle_breakpoint)
       "[T]oggle [B]reakpoint")
  (map :<leader>tr (. (. (require :dap) :repl) :open) "[T]oggle [R]epl")
  (map :<leader>to (. (. (. (require :telescope) :extensions) :dap) :commands)
       "[T]oggle telescope commands picker")
  (map :<leader>tt (. (require :dapui) :toggle) "[T][T]oggle dap ui")
  (map :<A-o> jdtls.organize_imports "Organize Imports"))

(fn configure [_ opts]
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
          :root_dir (vim.fs.root 0 [:.git])
          :settings {:completion {:favoriteStaticMembers [:org.hamcrest.MatcherAssert.assertThat
                                                          :org.hamcrest.Matchers.*
                                                          :org.hamcrest.CoreMatchers.*
                                                          :org.junit.jupiter.api.Assertions.*
                                                          :java.util.Objects.requireNonNull
                                                          :java.util.Objects.requireNonNullElse
                                                          :org.mockito.Mockito.*]
                                  :importOrder [:java :javax :org :com "\\#"]}
                     :contentProvider {:preferred :fernflower}
                     :java {:configuration {:runtimes [{:name :JavaSE-17
                                                        :path java-17}
                                                       {:name :JavaSE-11
                                                        :path java-11}]
                                            :updateBuildConfiguration :interactive}
                            :format {:settings {:url (.. java-share-dir
                                                         :codestyle.xml)}}
                            :implementationsCodeLens {:enabled true}
                            :maven {:downloadSources true
                                    :updateSnapshots false}
                            :referencesCodeLens {:enabled true}
                            :saveActions {:organizeImports true}}
                     :signatureHelp {:enabled true}
                     :sources {:organizeImports {:starThreshold 9999
                                                 :staticStarThreshold 9999}}}})
  (setup_jdtls config))

[(uu.tx :mfussenegger/nvim-jdtls {:config configure
                                  :dependencies [(uu.tx :mfussenegger/nvim-dap)]
                                  :ft [:java]
                                  :lazy true})]
