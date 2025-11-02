(local uu (require :cal.util))
[(uu.tx :mfussenegger/nvim-lint
        {:config (fn []
                   (local lint (require :lint))
                   (set lint.linters_by_ft
                        {;:markdown [:markdownlint]
                         :python [:mypy]
                         :groovy [:npm-groovy-lint]})
                   (local lint-augroup
                          (vim.api.nvim_create_augroup :lint {:clear true}))
                   (vim.api.nvim_create_autocmd [:BufEnter
                                                 :BufWritePost
                                                 :InsertLeave]
                                                {:callback (fn []
                                                             ((. (require :lint)
                                                                 :try_lint)))
                                                 :group lint-augroup}))
         :event [:BufReadPre :BufNewFile]})]
