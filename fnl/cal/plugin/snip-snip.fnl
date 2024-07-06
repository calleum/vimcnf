(module cal.plugin.snip-snip)

(let [(ok? lsvl) (pcall #(require "luasnip.loaders.from_vscode"))]
  (when ok?
    (lsvl.lazy_load {})))
