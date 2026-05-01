(local uu (require :cal.util))

[(uu.tx :monkoose/neocodeium
        {:event :VeryLazy
         :config (fn []
                   (let [nc (require :neocodeium)
                         blink (require :blink.cmp)]
                     (nc.setup {:silent true
                                :filetypes {:TelescopePrompt false
                                            :gitcommit false
                                            :gitrebase false
                                            :help false}
                                :filter (fn []
                                          (not (blink.is_visible)))})
                     (vim.api.nvim_create_autocmd :User
                       {:pattern :BlinkCmpMenuOpen
                        :callback (fn [] (nc.clear))})
                     (vim.keymap.set :i :<A-f> nc.accept)
                     (vim.keymap.set :i :<A-e>
                       (fn [] (nc.cycle_or_complete)))
                     (vim.keymap.set :i :<A-r>
                       (fn [] (nc.cycle_or_complete -1)))))})]
