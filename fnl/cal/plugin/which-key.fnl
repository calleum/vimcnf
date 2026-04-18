(local uu (require :cal.util))

(fn setup-which-key []
  (let [wk (require :which-key)]
    (wk.setup {:notify false})
    (each [_ key (ipairs [:grn :grr :gra])]
      (pcall vim.keymap.del :n key))
    (wk.add [(uu.tx :<leader>c {:group "[C]ode"})
             (uu.tx :<leader>d {:group "[D]ocument"})
             (uu.tx :<leader>r {:group "[R]ename"})
             (uu.tx :<leader>s {:group "[S]earch"})
             (uu.tx :<leader>t {:group "[T]oggle"})
             (uu.tx :<leader>w {:group "[W]orkspace"})])))

[(uu.tx :folke/which-key.nvim
        {:event :VimEnter
         :config setup-which-key})]
