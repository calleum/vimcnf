(local uu (require :cal.util))

(fn format-buffer []
  ((. (require :conform) :format) {:async true :lsp_format :fallback}))

[(uu.tx :stevearc/conform.nvim
        {:lazy false
         :keys [(uu.tx :<leader>f format-buffer {:desc "[F]ormat buffer"})]
         :opts {:format_on_save {:lsp_format :fallback :timeout_ms 500}
                :formatters_by_ft {:lua [:stylua]
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
