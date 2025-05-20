(local uu (require :cal.util))
[(uu.tx :ckipp01/nvim-jenkinsfile-linter
  {:config (fn []
             (local jenkins-linter (require :jenkinsfile_linter))
                               (vim.keymap.set :n :<leader>lj jenkins-linter.validate
                                   {})

               )})]
