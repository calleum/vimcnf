(module cal.plugin.which-key)

(let [(ok? which-key) (pcall #(require :which-key))]
  (when ok?
    (which-key.setup {})))
