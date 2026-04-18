(local uu (require :cal.util))

(fn setup-which-key []
  (let [wk (require :which-key)]
    (wk.setup {:notify false})
    (each [_ key (ipairs [:grn :grr :gra])]
      (pcall vim.keymap.del :n key))
    (wk.add [{1 :<leader>c :group "[C]ode"}
             {1 :<leader>d :group "[D]ocument"}
             {1 :<leader>r :group "[R]ename"}
             {1 :<leader>s :group "[S]earch"}
             {1 :<leader>t :group "[T]oggle"}
             {1 :<leader>w :group "[W]orkspace"}])))

[(uu.tx :folke/which-key.nvim
        {:event :VimEnter
         :config setup-which-key})]
