(module cal.plugin.neogen)

(let [(ok? neogen) (pcall #(require :neogen))]
  (when ok?
    (neogen.setup {})))
 
