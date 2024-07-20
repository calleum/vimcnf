(local vim _G.vim)
[{1 :folke/which-key.nvim
  :config (fn []
            ((. (require :which-key) :setup) {:notify false})
            (vim.keymap.del :n :grn)
            (vim.keymap.del :n :grr)
            (vim.keymap.del :n :gra)
            ((. (require :which-key) :register) {1 :<leader>c :group "[C]ode"}
                                                {1 :<leader>c_ :hidden true}
                                                {1 :<leader>d
                                                 :group "[D]ocument"}
                                                {1 :<leader>d_ :hidden true}
                                                {1 :<leader>r
                                                 :group "[R]ename"}
                                                {1 :<leader>r_ :hidden true}
                                                {1 :<leader>s
                                                 :group "[S]earch"}
                                                {1 :<leader>s_ :hidden true}
                                                {1 :<leader>t
                                                 :group "[T]oggle"}
                                                {1 :<leader>t_ :hidden true}
                                                {1 :<leader>w
                                                 :group "[W]orkspace"}
                                                {1 :<leader>w_ :hidden true})
            ; ((. (require :which-key) :register) {:<leader>h ["Git [H]unk"]} ; {:mode :v}))
            )
  :event :VimEnter}]
