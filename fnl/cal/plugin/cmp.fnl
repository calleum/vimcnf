(local uu (require :cal.util))

[(uu.tx :saghen/blink.cmp
        {:version "v0.*"
         :opts {:keymap {:preset :default
                         :<C-space> [:show :show_documentation :hide]
                         :<C-e> [:hide]
                         :<C-y> [:select_and_accept]
                         :<C-p> [:select_prev :fallback]
                         :<C-n> [:select_next :fallback]
                         :<C-b> [:scroll_documentation_up :fallback]
                         :<C-f> [:scroll_documentation_down :fallback]}
                :completion {:list {:selection {:preselect (fn [ctx] (not= ctx.mode :cmdline))
                                                :auto_insert (fn [ctx] (not= ctx.mode :cmdline))}}
                             :menu {:auto_show true}
                             :ghost_text {:enabled true}}
                :appearance {:use_nvim_get_hl true
                             :nerd_font_variants {:mono :NerdFontMono
                                                  :normal :NerdFont}}
                :sources {:default [:lsp :path :snippets :buffer]}}
         :dependencies [:rafamadriz/friendly-snippets]})]
