(module cal.plugin.rust
  {autoload {util cal.util
             nvim aniseed.nvim}})

(defn- map [from to]
  (util.nnoremap from to))


(let [(ok? rt) (pcall #(require :rust-tools))]
  (when ok?
(fn rt-on-attach [_ bufnr]
  (local opts {:buffer bufnr})
  (map :K "lua require'rust-tools'.hover_actions.hover_actions()")
  (map :<leader>a "lua require'rust-tools'.code_action_group.code_action_group()")
  (map :<leader>ru "lua require'rust-tools'.runnables.runnables()")
  nil)

(local rt-opts {:server {:capabilities ((. (require :cmp_nvim_lsp)
                                           :default_capabilities))
                         :on_attach rt-on-attach
                         :settings {:rust-analyzer {:diagnostics {:enable true
                                                                  :experimental {:enable true}}}}
                         :standalone false}
                :tools {:inlay_hints {:auto false
                                      :disable true
                                      :other_hints_prefix ""
                                      :parameter_hints_prefix ""
                                      :show_parameter_hints false}
                        :runnables {:use_telescope true}}})
(rt.setup rt-opts)
(rt.inlay_hints.disable)))
