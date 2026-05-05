(local uu (require :cal.util))

[(uu.tx :saghen/blink.cmp
        {:version :v0.*
         :dependencies [:rafamadriz/friendly-snippets]
         :opts {:keymap {:preset :default
                         :<C-space> [:show :show_documentation :hide]
                         :<C-e> [:hide]
                         :<C-y> [:select_and_accept]
                         :<C-p> [:select_prev :fallback]
                         :<C-n> [:select_next :fallback]
                         :<C-b> [:scroll_documentation_up :fallback]
                         :<C-f> [:scroll_documentation_down :fallback]}
                :completion {:list {:selection {:preselect (fn [{: mode}]
                                                             (not= mode
                                                                   :cmdline))
                                                :auto_insert (fn [{: mode}]
                                                               (not= mode
                                                                     :cmdline))}}
                             :menu {:auto_show true}
                             :ghost_text {:enabled true}}
                :appearance {:nerd_font_variant :mono}
                :sources {:default [:lsp :path :snippets :buffer]}}})]
