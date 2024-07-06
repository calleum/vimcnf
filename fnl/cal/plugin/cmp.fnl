(module cal.plugin.cmp
  {autoload {nvim aniseed.nvim}})

(set nvim.o.completeopt "menuone,noselect")

; (let [(ok? cmp) (pcall require :cmp)]
;   (when ok?
;     (cmp.setup
;       {:sources [{:name "conjure"}
;                  {:name "nvim_lsp"}
;                  {:name "buffer"}
;                  {:name "path"}]
;        :mapping (cmp.mapping.preset.insert
;                   {"<C-b>" (cmp.mapping.scroll_docs -4)
;                    "<C-f>" (cmp.mapping.scroll_docs 4)
;                    "<C-Space>" (cmp.mapping.complete)
;                    "<C-e>" (cmp.mapping.abort)
;                    "<C-CR>" (cmp.mapping.confirm {:select true})})})))

(let [(cmp/ok? cmp) (pcall require :cmp)]
  (when cmp/ok?
    (let [(luasnip/ok? luasnip) (pcall require :luasnip)]
      (when luasnip/ok?
        (cmp.setup 
          {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete {})
                                                       :<C-d> (cmp.mapping.scroll_docs  -4)
                                                       :<C-f> (cmp.mapping.scroll_docs 4)
                                                       :<C-n> (cmp.mapping.select_next_item)
                                                       :<C-p> (cmp.mapping.select_prev_item)
                                                       :<CR> (cmp.mapping.confirm {:select false})
                                                       })
                  :snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
                  :sources [{:keyword_length 3 :name :nvim_lsp}
                            {:keyword_length 3
                             :name :nvim_lsp_signature_help}
                            {:name "conjure"}
                            {:keyword_length 3 :max_item_count 4 :name :nvim_lua}
                            {:keyword_length 2 :max_item_count 4 :name :luasnip}
                            {:keyword_length 5 :max_item_count 2 :name :buffer}
                            {:keyword_length 3 :name :path}
                            {:name :calc}]})
((. (require :luasnip.loaders.from_lua) :load) {:paths :./snippets})
((. (require :luasnip.loaders.from_vscode) :load) {:paths :./snippets})
((. (require :luasnip.loaders.from_vscode) :lazy_load))))))
