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
                                                             (map :gr
                                                                  (. (require :telescope.builtin)
                                                                     :lsp_references)
                                                                  "[G]oto [R]eferences")
                                                             (map :gI
                                                                  (. (require :telescope.builtin)
                                                                     :lsp_implementations)
                                                                  "[G]oto [I]mplementation")
                                                             (map :<leader>lC
                                                                  "<Cmd>Lspsaga outgoing_calls<CR>"
                                                                  "[l]oad outgoing [C]alls")
                                                             (map :<leader>lc
                                                                  "<Cmd>Lspsaga incoming_calls<CR>"
                                                                  "[l]oad incoming [c]alls")
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
                   (var capabilities
                        (vim.lsp.protocol.make_client_capabilities))
                   (set capabilities
                        (vim.tbl_deep_extend :force capabilities
                                             ((. (require :cmp_nvim_lsp)
                                                 :default_capabilities))))
                   (local servers
                          {:pyright {:settings {:pyright {:disableOrganizeImports true}
                                                :python {:analysis {:ignore [""]}
                                                         :diagnosticMode :workspace}}}
                           :lemminx {:settings {:xml {:format {:enabled false
                                                               :splitAttributes false
                                                               :joinCDATALines true
                                                               ; :joinContentLines true
                                                               }}}}
                           :ruff {:on_attach (fn [client bufnr]
                                               (when (= client.name :ruff)
                                                 (set client.server_capabilities.hoverProvider
                                                      false)))}
                           :fennel_language_server {:settings {:fennel [{:workspace {:library (vim.api.nvim_list_runtime_paths)}}
                                                                        {:diagnostics {:globals [:vim]}}]}}
                           :lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}})
                   ((. (require :mason) :setup))
                   (local ensure-installed (vim.tbl_keys (or servers {})))
                   (vim.list_extend ensure-installed [:stylua])
                   ((. (require :mason-tool-installer) :setup) {:ensure_installed ensure-installed})
                   ((. (require :mason-lspconfig) :setup) {:handlers [(fn [server-name]
                                                                        (local server
                                                                               (or (. servers
                                                                                      server-name)
                                                                                   {}))
                                                                        (set server.capabilities
                                                                             (vim.tbl_deep_extend :force
                                                                                                  {}
                                                                                                  capabilities
                                                                                                  (or server.capabilities
                                                                                                      {})))
                                                                        ((. (. (require :lspconfig)
                                                                               server-name)
                                                                            :setup) server))]}))
         :dependencies [{1 :williamboman/mason.nvim :config true}
                        :williamboman/mason-lspconfig.nvim
                        ; (uu.tx :nvimdev/lspsaga.nvim
                        ;        {:config (fn []
                        ;                   ((. (require :lspsaga) :setup) {}))})
                        :WhoIsSethDaniel/mason-tool-installer.nvim
                        {1 :folke/neodev.nvim :opts {}}]})
 ; (uu.tx :ray-x/lsp_signature.nvim
 ;        {:config (fn [_ opts]
 ;                   ((. (require :lsp_signature) :setup) opts))
 ;         :event :VeryLazy
 ;         :opts {:cursorhold_update false :hint_enable false :zindex 45}})
 ; (uu.tx "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
 ;        {:branch :main
 ;         :config (fn []
 ;                   ((. (require :lsp_lines) :setup) {}))
 ;         :event :LspAttach})
 (uu.tx :folke/trouble.nvim
        {:cmd :Trouble :lazy true :opts {:auto_preview false :focus true}})]
