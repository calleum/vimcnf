(local uu (require :cal.util))

[(uu.tx :danymat/neogen
        {:config (fn []
                   ((. (require :neogen) :setup) {:snippet_engine :luasnip})
                   (local opts {:noremap true :silent true})
                   (vim.api.nvim_set_keymap :n :<Leader>nd
                                            ":lua require('neogen').generate()<CR>"
                                            opts))})]
