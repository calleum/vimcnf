(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))

(let [(ok? material) (pcall #(require :material))]
  (when ok?
    (material.setup {:custom_highlights {:FloatBorder {:fg "#1A1A1A"}}
                     :borders true
                     :high_visibility {:darker true}
                     :custom_colors (fn [colors]
                                      (set colors.syntax.string "#C792EA"))})
    (set nvim.g.material_style :darker)
    (nvim.ex.colorscheme :material)))
