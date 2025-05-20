(local vim _G.vim)
(local uu (require :cal.util))
[(uu.tx :nvim-neotest/neotest-python)
 (uu.tx :nvim-neotest/neotest-plenary)
 (uu.tx :nvim-neotest/neotest
        {:config (fn []
                   ((. (require :neotest) :setup) {:adapters [((require :neotest-python) {:dap {:justMyCode false}})
                                                              (require :neotest-plenary)]})
                   (vim.keymap.set :n :<leader>ra
                                   (fn []
                                     ((. (require :neotest) :run :run) (vim.fn.expand "%")))
                                   {:desc "[R]un [A]ll neotests in current file"})
                   :dependencies
                   [:nvim-neotest/nvim-nio
                    :nvim-neotest/neotest-plenary
                    :antoinemadec/FixCursorHold.nvim
                    :nvim-treesitter/nvim-treesitter])})]
