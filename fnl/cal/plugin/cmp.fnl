(local uu (require :cal.util))

[(uu.tx :saghen/blink.cmp
        {:version "v0.*"
         :opts {:keymap {:preset :default}
                :appearance {:use_nvim_get_hl true
                             :nerd_font_variants {:mono :NerdFontMono
                                                  :normal :NerdFont}}
                :sources {:default [:lsp :path :snippets :buffer]}}
         :dependencies [:rafamadriz/friendly-snippets]})]
