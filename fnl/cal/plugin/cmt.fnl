(module cal.plugin.cmt)

(let [(ok? cmt) (pcall #(require :Comment))]
  (when ok?
    (cmt.setup {})))
