(local uu (require :cal.util))
(uu.tx :nvim-mini/mini.nvim
       {:config (fn []
                  ((. (require :mini.ai) :setup))
                  ((. (require :mini.surround) :setup))
                  (local hipatterns (require :mini.hipatterns))
                  (hipatterns.setup {:highlighters {:hex_color (hipatterns.gen_highlighter.hex_color)}})
                  (local statusline (require :mini.statusline))
                  (statusline.setup {:use_icons vim.g.have_nerd_font})
                  (set statusline.section_location (fn [] "%2l:%-2v")))})
