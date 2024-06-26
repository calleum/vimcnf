(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))

(defn setup
  []
  (let [auto-pairs nvim.g.AutoPairs]
    (when auto-pairs
      (tset auto-pairs "'" nil)
      (tset auto-pairs "`" nil)
      (set nvim.b.AutoPairs auto-pairs))))

(augroup auto-pairs-config
         (nvim.ex.autocmd :FileType "clojure,fennel,scheme"
                          (.. "call v:lua.require('" *module-name* "').setup()")))
