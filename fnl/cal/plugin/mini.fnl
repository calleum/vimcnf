(local uu (require :cal.util))

(fn setup-mini []
  ((. (require :mini.ai) :setup))
  ((. (require :mini.surround) :setup))
  (let [hipatterns (require :mini.hipatterns)
        statusline (require :mini.statusline)]
    (hipatterns.setup {:highlighters {:hex_color (hipatterns.gen_highlighter.hex_color)}})
    (statusline.setup {:use_icons vim.g.have_nerd_font})
    (set statusline.section_location #"%2l:%-2v")))

[(uu.tx :nvim-mini/mini.nvim {:config setup-mini})]
