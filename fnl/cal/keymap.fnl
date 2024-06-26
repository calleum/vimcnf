(local uu (require :cal.util))

(uu.remap :<S-F7> ":%s/\\s\\+$//g<CR>" {})
(uu.remap :n :nzz {:noremap true :silent true})
(uu.remap :N :Nzz {:noremap true :silent true})
(uu.remap "*" :*zz {:noremap true :silent true})
(uu.remap "#" "#zz" {:noremap true :silent true})
(uu.remap :g* :g*zz {:noremap true :silent true})
(uu.remap "/" "/\\v" {:noremap true :silent false})
