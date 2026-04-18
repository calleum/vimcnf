(local uu (require :cal.util))

[(uu.tx :folke/snacks.nvim {:keys [(uu.tx :<leader>z (fn [] (Snacks.zen))
                                          {:desc "Toggle Zen Mode"})
                                   (uu.tx :<leader>Z (fn [] (Snacks.zen.zoom))
                                          {:desc "Toggle Zoom"})
                                   (uu.tx :<leader>. (fn [] (Snacks.scratch))
                                          {:desc "Toggle Scratch Buffer"})
                                   (uu.tx :<leader>S
                                          (fn [] (Snacks.scratch.select))
                                          {:desc "Select Scratch Buffer"})
                                   (uu.tx :<leader>n
                                          (fn [] (Snacks.notifier.show_history))
                                          {:desc "Notification History"})
                                   (uu.tx :<leader>bd
                                          (fn [] (Snacks.bufdelete))
                                          {:desc "Delete Buffer"})
                                   (uu.tx :<leader>un
                                          (fn [] (Snacks.notifier.hide))
                                          {:desc "Dismiss All Notifications"})
                                   (uu.tx :<leader>N
                                          (fn []
                                            (Snacks.win {:file (. (vim.api.nvim_get_runtime_file :doc/news.txt
                                                                                                 false)
                                                                  1)
                                                         :height 0.6
                                                         :width 0.6
                                                         :wo {:conceallevel 3
                                                              :signcolumn :yes
                                                              :spell false
                                                              :statuscolumn " "
                                                              :wrap false}}))
                                          {:desc "Neovim News"})]
                            :lazy false
                            :opts {:bigfile {:enabled true}
                                   :dashboard {:enabled true}
                                   :explorer {:enabled true}
                                   :indent {:enabled true}
                                   :input {:enabled true}
                                   :notifier {:enabled true :timeout 3000}
                                   :picker {:enabled true}
                                   :quickfile {:enabled true}
                                   :statuscolumn {:enabled true}
                                   :styles {:notification {}}
                                   :words {:enabled true}}
                            :priority 1000})]
