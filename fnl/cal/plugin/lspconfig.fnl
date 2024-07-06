(module cal.plugin.lspconfig
  {autoload {util cal.util
             nvim aniseed.nvim}})

(defn- map [from to]
  (util.nnoremap from to))

(defn- load-server [lsp server config]
  ((. (. lsp server) :setup) [config]))

(let [(ok? lsp) (pcall #(require :lspconfig))]
  (when ok?
    (let [(lsp-cmp/ok? lsp-cmp) (pcall require :cmp_nvim_lsp)]
      (when lsp-cmp/ok? 
        (local capabilities (lsp-cmp.default_capabilities nvim.lsp_protocol_make_client_capabilities))
        (local servers [:clangd
                    :bashls
                    :texlab
                    :gopls
                    :hls
                    :dockerls
                    :tsserver
                    :racket_langserver])
        (each [_ lsp-conf (ipairs servers)]
        (load-server lsp lsp-conf {:on_attach capabilities}
          ))
        (lsp.clojure_lsp.setup {})
        (lsp.tsserver.setup {})
        (lsp.pylsp.setup {})
        (lsp.lua_ls.setup
          {:cmd ["lua-language-server"]
           :settings {:Lua [{:workspace {:library (nvim.list_runtime_paths)}}
                            {:diagnostics {:globals ["vim"]}}
                            {:telemetry {:enable false}}]}})

        (lsp.fennel_language_server.setup
          {:settings {:fennel [{:workspace {:library (nvim.list_runtime_paths)}}
                              {:diagnostics {:globals ["vim"]}}]
                              }})


        ;; https://www.chrisatmachine.com/Neovim/27-native-lsp/
        (map :gd "lua vim.lsp.buf.definition()")
        (map :gD "lua vim.lsp.buf.declaration()")
        (map :gr "lua vim.lsp.buf.references()")
        (map :gi "lua vim.lsp.buf.implementation()")
        (map :K "lua vim.lsp.buf.hover()")
        (map :<c-k> "lua vim.lsp.buf.signature_help()")
        (map :<c-p> "lua vim.diagnostic.goto_prev()")
        (map :<c-n> "lua vim.diagnostic.goto_next()")

        (map :<leader>ed "lua vim.diagnostic.open_float()")
        (map :<leader>ca "lua vim.lsp.buf.code_action()")
        (map :<leader>rr "lua vim.lsp.buf.rename()")
        (map :<leader>lf "lua vim.lsp.buf.format({async = true})")))))

