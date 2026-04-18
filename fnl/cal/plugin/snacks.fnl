(local uu (require :cal.util))

[(uu.tx :folke/snacks.nvim
        {:priority 1000
         :lazy false
         :opts {:bigfile {:enabled true}
                :notifier {:enabled true}
                :quickfile {:enabled true}
                :statuscolumn {:enabled true}
                :words {:enabled true}
                :styles {:notification {:wo {:wrap true}}}}
         :keys [{1 :<leader>n :2 (fn [] (let [S (require :snacks)] (S.notifier.show_history))) :desc "Notification History"}
                {1 :<leader>un :2 (fn [] (let [S (require :snacks)] (S.notifier.hide))) :desc "Dismiss All Notifications"}]})]
