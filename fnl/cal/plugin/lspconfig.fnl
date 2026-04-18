(local vim _G.vim)
(local uu (require :cal.util))
[(uu.tx :neovim/nvim-lspconfig
        {:config (fn []
                   (vim.api.nvim_create_autocmd :LspAttach
                                                {:callback (fn [event]
                                                             (fn map [keys
                                                                      func
                                                                      desc]
                                                               (vim.keymap.set :n
                                                                               keys
                                                                               func
                                                                               {:buffer event.buf
                                                                                :desc (.. "LSP: "
                                                                                          desc)}))

                                                             (map :gd
                                                                  (. (require :telescope.builtin)
                                                                     :lsp_definitions)
                                                                  "[G]oto [D]efinition")
                                                             (map :<leader>oi
                                                                  #(vim.lsp.buf.code_action {:apply true
                                                                                             :context {:only [:source.organizeImports]}})
                                                                  "[O]rganize [I]mports")
                                                             (map :gr
                                                                  (fn []
                                                                    ((. (require :telescope.builtin)
                                                                        :lsp_references) {:path_display [:truncate]
                                                                                          :fname_width 60}))
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
                                                             (map :<leader>rn
                                                                  vim.lsp.buf.rename
                                                                  "[R]e[n]ame")
                                                             (map :<leader>ca
                                                                  vim.lsp.buf.code_action
                                                                  "[C]ode [A]ction")
                                                             (map :K
                                                                  vim.lsp.buf.hover
                                                                  "Hover Documentation")
                                                             (map :gD
                                                                  vim.lsp.buf.declaration
                                                                  "[G]oto [D]eclaration")
                                                             (local client
                                                                    (vim.lsp.get_client_by_id event.data.client_id))
                                                             (when (and client
                                                                        client.server_capabilities.documentHighlightProvider)
                                                               (local highlight-augroup
                                                                      (vim.api.nvim_create_augroup :kickstart-lsp-highlight
                                                                                                   {:clear false}))
                                                               (vim.api.nvim_create_autocmd [:CursorHold
                                                                                             :CursorHoldI]
                                                                                            {:buffer event.buf
                                                                                             :callback vim.lsp.buf.document_highlight
                                                                                             :group highlight-augroup})
                                                               (vim.api.nvim_create_autocmd [:CursorMoved
                                                                                             :CursorMovedI]
                                                                                            {:buffer event.buf
                                                                                             :callback vim.lsp.buf.clear_references
                                                                                             :group highlight-augroup})
                                                               (vim.api.nvim_create_autocmd :LspDetach
                                                                                            {:callback (fn [event2]
                                                                                                         (vim.lsp.buf.clear_references)
                                                                                                         (vim.api.nvim_clear_autocmds {:buffer event2.buf
                                                                                                                                       :group :kickstart-lsp-highlight}))
                                                                                             :group (vim.api.nvim_create_augroup :kickstart-lsp-detach
                                                                                                                                 {:clear true})}))
                                                             (when (and (and client
                                                                             client.server_capabilities.inlayHintProvider)
                                                                        vim.lsp.inlay_hint)
                                                               (map :<leader>th
                                                                    (fn []
                                                                      (vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled))))
                                                                    "[T]oggle Inlay [H]ints")))
                                                 :group (vim.api.nvim_create_augroup :kickstart-lsp-attach
                                                                                     {:clear true})})
                   (local blink (require :blink.cmp))
                   (local capabilities (blink.get_lsp_capabilities))
                   (local mason-servers
                          {:fish_lsp {}
                           :basedpyright {}
                           :lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}})
                   (local system-servers
                          {:rust-analyzer {} :fennel_language_server {}})
                   (local servers
                          (vim.tbl_deep_extend :force mason-servers
                                               system-servers))
                   (local ensure-installed (vim.tbl_keys mason-servers))
                   (vim.list_extend ensure-installed [:stylua])
                   (local mason-path (vim.fn.expand :$MASON/packages))
                   (local vue-language-server-path
                          (.. mason-path
                              "/vue-language-server/node_modules/@vue/language-server"))
                   (local vue-plugin
                          {:name "@vue/typescript-plugin"
                           :location vue-language-server-path
                           :languages [:vue]
                           :configNamespace :typescript})
                   (local tsserver-filetypes
                          [:typescript
                           :javascript
                           :javascriptreact
                           :typescriptreact
                           :vue])
                   (local vtsls-config
                          {:filetypes tsserver-filetypes
                           :settings {:vtsls {:tsserver {:globalPlugins [vue-plugin]}}}})
                   (local vue-ls-config {})
                   (vim.lsp.config :vtsls vtsls-config)
                   (vim.lsp.config :vue_ls vue-ls-config)

                   (fn view [list]
                     (table.concat (icollect [_ val (ipairs list)]
                                     (.. "[" val "]"))
                                   " | "))

                   ((. (require :mason) :setup))
                   ((. (require :mason-tool-installer) :setup) {:ensure_installed ensure-installed})
                   ((. (require :mason-lspconfig) :setup) {:handlers [(fn [server-name]
                                                                        (local server-opts
                                                                               (or (. servers
                                                                                      server-name)
                                                                                   {}))
                                                                        (set server-opts.capabilities
                                                                             (vim.tbl_deep_extend :force
                                                                                                  (or server-opts.capabilities
                                                                                                      {})
                                                                                                  capabilities))
                                                                        (vim.notify (view server-name))
                                                                        ((. (. (require :lspconfig)
                                                                               server-name)
                                                                            :setup) server-opts))]})
                   (local all-servers-to-enable (vim.tbl_keys servers))
                   (vim.list_extend all-servers-to-enable [:vtsls :vue_ls])
                   (vim.notify (view all-servers-to-enable))
                   (vim.lsp.enable all-servers-to-enable))
         :dependencies [{1 :williamboman/mason.nvim :config true}
                        :williamboman/mason-lspconfig.nvim
                        :WhoIsSethDaniel/mason-tool-installer.nvim
                        {1 :folke/lazydev.nvim :opts {}}
                        :saghen/blink.cmp]})]
