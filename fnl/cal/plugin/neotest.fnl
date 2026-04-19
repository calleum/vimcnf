(local uu (require :cal.util))

(fn run-all-tests []
  ((. (require :neotest) :run :run) (vim.fn.expand "%")))

[(uu.tx :nvim-neotest/neotest
        {:dependencies [:nvim-neotest/nvim-nio
                        :nvim-neotest/neotest-plenary
                        :nvim-neotest/neotest-python
                        :nvim-treesitter/nvim-treesitter]
         :keys [(uu.tx :<leader>ra run-all-tests
                       {:desc "[R]un [A]ll neotests in current file"})]
         :config (fn []
                   ((. (require :neotest) :setup) {:adapters [(require :neotest-python)
                                                              (require :neotest-plenary)]}))})]
