(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))
(local vim _G.vim)

(fn map [...]
  (uu.nmap-mi ...))

(fn load-server [lsp server config]
  ((. (. lsp server) :setup) [config]))

(let [(ok? lsp) (pcall #(require :lspconfig))]
  (when ok?
    (let [(lsp-cmp/ok? lsp-cmp) (pcall require :cmp_nvim_lsp)]
      (when lsp-cmp/ok?
        (local capabilities
               (lsp-cmp.default_capabilities nvim.lsp_protocol_make_client_capabilities))
        (local servers [:clangd
                        :bashls
                        :texlab
                        :gopls
                        :dockerls
                        :tsserver
                        :racket_langserver])
        (each [_ lsp-conf (ipairs servers)]
          (load-server lsp lsp-conf {:on_attach capabilities}))
        (lsp.clojure_lsp.setup {})
        (lsp.tsserver.setup {})
        (lsp.pylsp.setup {})
        (lsp.lua_ls.setup {:cmd [:lua-language-server]
                           :settings {:Lua [{:workspace {:library (nvim.list_runtime_paths)}}
                                            {:diagnostics {:globals [:vim]}}
                                            {:telemetry {:enable false}}]}})
        (lsp.fennel_language_server.setup {:settings {:fennel [{:workspace {:library (vim.api.nvim_list_runtime_paths)}}
                                                               {:diagnostics {:globals [:vim]}}]}})
        ;; https://www.chrisatmachine.com/Neovim/27-native-lsp/
        (map :gd vim.lsp.buf.definition :vim.lsp.buf.definition)
        (map :gD vim.lsp.buf.declaration :vim.lsp.buf.declaration)
        (map :gr vim.lsp.buf.references :vim.lsp.buf.references)
        (map :gi vim.lsp.buf.implementation :vim.lsp.buf.implementation)
        (map :K vim.lsp.buf.hover :vim.lsp.buf.hover)
        (map :<c-k> vim.lsp.buf.signature_help :vim.lsp.buf.signature_help)
        (map :<c-p> vim.diagnostic.goto_prev :vim.diagnostic.goto_prev)
        (map :<c-n> vim.diagnostic.goto_next :vim.diagnostic.goto_next)
        (map :<leader>ed vim.diagnostic.open_float :vim.diagnostic.open_float)
        (map :<leader>ca vim.lsp.buf.code_action :vim.lsp.buf.code_action)
        (map :<leader>rr vim.lsp.buf.rename :vim.lsp.buf.rename)
        (map :<leader>lf vim.lsp.buf.format :vim.lsp.buf.format)))))

((. (require :fidget) :setup) {})
