[{1 :folke/which-key.nvim
  :config (fn []
            ((. (require :which-key) :setup))
            ((. (require :which-key) :register) {:<leader>c {:_ :which_key_ignore
                                                             :name "[C]ode"}
                                                 :<leader>d {:_ :which_key_ignore
                                                             :name "[D]ocument"}
                                                 ; :<leader>h {:_ :which_key_ignore
                                                 ;             :name "Git [H]unk"}
                                                 :<leader>r {:_ :which_key_ignore
                                                             :name "[R]ename"}
                                                 :<leader>s {:_ :which_key_ignore
                                                             :name "[S]earch"}
                                                 :<leader>t {:_ :which_key_ignore
                                                             :name "[T]oggle"}
                                                 :<leader>w {:_ :which_key_ignore
                                                             :name "[W]orkspace"}})
            ; ((. (require :which-key) :register) {:<leader>h ["Git [H]unk"]}
                                                ; {:mode :v}))
                                                )
  :event :VimEnter}]
