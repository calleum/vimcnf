(local vim _G.vim)
{1 :ThePrimeagen/refactoring.nvim
 :config (fn []
           ((. (require :refactoring) :setup) {})
           (vim.keymap.set [:n :x] :<leader>ri
                           (fn []
                             ((. (require :refactoring) :refactor) "Inline Variable"))
                           {:expr true})
           (vim.keymap.set [:n :x] :<leader>rr
                           (fn []
                             ((. (require :refactoring) :select_refactor)))
                           {:desc "Refactor: Select Refactor"
                            :noremap true
                            :silent true}))
 :dependencies [:nvim-lua/plenary.nvim :nvim-treesitter/nvim-treesitter]
 :lazy false
 ; :ft [:java]
 :keys [{1 :<leader>rr :desc "Refactor: Select Refactor" :mode [:n :x]}]}
