(local uu (require :cal.util))

[(uu.tx :stevearc/conform.nvim
        {:keys [(uu.tx :<leader>f
                       (fn []
                         ((. (require :conform) :format) {:async true
                                                          :lsp_format :fallback}))
                       :desc "[F]ormat buffer" :mode "")]
         :lazy false
         :opts {:format_on_save {:lsp_format :fallback :timeout_ms 500}
                :formatters_by_ft {:lua [:stylua]
                                   :markdown [:markdownlint :markdown-toc]
                                   :rust [:rustfmt]
                                   :vue [:eslint_d]
                                   :make [:bake]
                                   :bash [:shfmt]
                                   :sh [:shfmt]
                                   :json [:jq]
                                   :latex [:tex-fmt]
                                   :fennel [:fnlfmt]
                                   :nix [:nixfmt]
                                   :python [:black]}}})]
