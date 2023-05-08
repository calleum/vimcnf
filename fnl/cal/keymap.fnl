(module cal.keymap
  {autoload {util cal.util
             nvim aniseed.nvim}})

(defn- map [from to opts]
  (util.nnoremap from to opts))

(util.lnnoremap :nd "lua require'neogen'.generate() <CR>" {})
(util.remap :<S-F7> ":%s/\\s\\+$//g<CR>" {})
(util.remap :n :nzz {:noremap true :silent true})
(util.remap :N :Nzz {:noremap true :silent true})
(util.remap "*" :*zz {:noremap true :silent true})
(util.remap "#" "#zz" {:noremap true :silent true})
(util.remap :g* :g*zz {:noremap true :silent true})
(util.remap "/" "/\\v" {:noremap true :silent false})
