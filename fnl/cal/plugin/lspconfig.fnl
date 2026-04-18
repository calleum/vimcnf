(local uu (require :cal.util))

(fn set-lsp-keymaps [bufnr]
  "Defines buffer-local keybindings for the attached LSP."
  (let [builtin (require :telescope.builtin)
        maps [[:gd builtin.lsp_definitions "Goto Definition"]
              [:gr
               #(builtin.lsp_references {:path_display [:truncate]
                                         :fname_width 60})
               "Goto References"]
              [:gI builtin.lsp_implementations "Goto Implementation"]
              [:<leader>D builtin.lsp_type_definitions "Type Definition"]
              [:<leader>ds builtin.lsp_document_symbols "Document Symbols"]
              [:<leader>ws
               builtin.lsp_dynamic_workspace_symbols
               "Workspace Symbols"]
              [:<leader>rn vim.lsp.buf.rename :Rename]
              [:<leader>ca vim.lsp.buf.code_action "Code Action"]
              [:K vim.lsp.buf.hover "Hover Documentation"]
              [:gD vim.lsp.buf.declaration "Goto Declaration"]
              [:<leader>oi
               #(vim.lsp.buf.code_action {:apply true
                                          :context {:only [:source.organizeImports]}})
               "Organize Imports"]]]
    (each [_ [lhs rhs desc] (ipairs maps)]
      (vim.keymap.set :n lhs rhs {:buffer bufnr :desc (.. "LSP: " desc)}))))

(fn setup-lsp-highlights [bufnr client]
  "Sets up document highlighting for the current buffer if supported by the client."
  (when (and client client.server_capabilities.documentHighlightProvider)
    (let [group (vim.api.nvim_create_augroup :lsp-highlight {:clear false})]
      (vim.api.nvim_create_autocmd [:CursorHold :CursorHoldI]
                                   {:buffer bufnr
                                    :callback vim.lsp.buf.document_highlight
                                    : group})
      (vim.api.nvim_create_autocmd [:CursorMoved :CursorMovedI]
                                   {:buffer bufnr
                                    :callback vim.lsp.buf.clear_references
                                    : group})
      (vim.api.nvim_create_autocmd :LspDetach
                                   {:callback (fn [event2]
                                                (vim.lsp.buf.clear_references)
                                                (vim.api.nvim_clear_autocmds {:buffer event2.buf
                                                                              : group}))
                                    :group (vim.api.nvim_create_augroup :lsp-detach
                                                                        {:clear true})}))))

(fn setup-lsp-inlay-hints [bufnr client]
  "Sets up a toggle for inlay hints if supported by the client."
  (when (and client client.server_capabilities.inlayHintProvider
             vim.lsp.inlay_hint)
    (vim.keymap.set :n :<leader>th
                    #(vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled)))
                    {:buffer bufnr :desc "LSP: Toggle Inlay Hints"})))

(fn on-lsp-attach [{:buf bufnr : data}]
  "The primary callback executed when an LSP client attaches."
  (let [client (vim.lsp.get_client_by_id data.client_id)]
    (set-lsp-keymaps bufnr)
    (setup-lsp-highlights bufnr client)
    (setup-lsp-inlay-hints bufnr client)))

(fn setup-lsp-attach-autocmd []
  "Registers the LspAttach autocommand."
  (vim.api.nvim_create_autocmd :LspAttach
                               {:callback on-lsp-attach
                                :group (vim.api.nvim_create_augroup :lsp-attach
                                                                    {:clear true})}))

;; --- Server & Mason Configuration ---

(fn get-server-config []
  (let [mason {:fish_lsp {}
               :basedpyright {}
               :lua_ls {:settings {:Lua {:completion {:callSnippet :Replace}}}}}
        system {:rust-analyzer {}
                :fennel_language_server {:root_dir ((. (require :lspconfig)
                                                       :util :root_pattern) :.nfnl.fnl
                                                                            :fnl
                                                                            :.git)
                                         :settings {:fennel {:diagnostics {:globals [:vim]}
                                                             :workspace {:library (vim.api.nvim_list_runtime_paths)}}}}}]
    {: mason : system :all (vim.tbl_deep_extend :force mason system)}))

(fn setup-vtsls []
  (let [mason-path (vim.fn.expand :$MASON/packages)
        vue-plugin {:name "@vue/typescript-plugin"
                    :location (.. mason-path
                                  "/vue-language-server/node_modules/@vue/language-server")
                    :languages [:vue]
                    :configNamespace :typescript}
        configs {:vtsls {:filetypes [:typescript
                                     :javascript
                                     :javascriptreact
                                     :typescriptreact
                                     :vue]
                         :settings {:vtsls {:tsserver {:globalPlugins [vue-plugin]}}}}
                 :vue_ls {}}]
    (each [name cfg (pairs configs)] (vim.lsp.config name cfg))
    (vim.tbl_keys configs)))

(fn setup-mason [mason-servers]
  ((. (require :mason) :setup))
  (let [ensure-installed (vim.tbl_keys mason-servers)]
    (table.insert ensure-installed :stylua)
    ((. (require :mason-tool-installer) :setup) {:ensure_installed ensure-installed})))

[(uu.tx :neovim/nvim-lspconfig
        {:config (fn []
                   (setup-lsp-attach-autocmd)
                   (let [capabilities ((. (require :blink.cmp)
                                          :get_lsp_capabilities))
                         {: mason :all all-servers} (get-server-config)
                         extra-names (setup-vtsls)]
                     (setup-mason mason)
                     ((. (require :mason-lspconfig) :setup) {:handlers [(fn [name]
                                                                          (let [opts (or (. all-servers
                                                                                            name)
                                                                                         {})]
                                                                            (set opts.capabilities
                                                                                 (vim.tbl_deep_extend :force
                                                                                                      (or opts.capabilities
                                                                                                          {})
                                                                                                      capabilities))
                                                                            (vim.notify (.. "LSP Setup: "
                                                                                            name))
                                                                            ((. (. (require :lspconfig)
                                                                                   name)
                                                                                :setup) opts)))]})
                     (let [to-enable (vim.tbl_keys all-servers)]
                       (vim.list_extend to-enable extra-names)
                       (vim.lsp.enable to-enable))))
         :dependencies [{1 :williamboman/mason.nvim :config true}
                        :williamboman/mason-lspconfig.nvim
                        :WhoIsSethDaniel/mason-tool-installer.nvim
                        {1 :folke/lazydev.nvim :opts {}}
                        :saghen/blink.cmp]})]
