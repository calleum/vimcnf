(local uu (require :cal.util))

(fn select-refactor []
  ((. (require :refactoring) :select_refactor)))

(fn inline-variable []
  ((. (require :refactoring) :refactor) "Inline Variable"))

[(uu.tx :ThePrimeagen/refactoring.nvim
        {:lazy false
         :dependencies [:nvim-lua/plenary.nvim :nvim-treesitter/nvim-treesitter]
         :keys [(uu.tx :<leader>rr select-refactor {:desc "Refactor: Select Refactor" :mode [:n :x]})
                (uu.tx :<leader>ri inline-variable {:desc "Refactor: Inline Variable" :mode [:n :x] :expr true})]
         :config (fn [] ((. (require :refactoring) :setup) {}))})]
