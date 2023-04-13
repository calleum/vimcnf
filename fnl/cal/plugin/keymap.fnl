(module cal.plugin.lspconfig
  {autoload {util cal.util
             nvim aniseed.nvim}})


(defn- map [from to]
  (util.nnoremap from to))

