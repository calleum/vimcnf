{1 :nvim-treesitter/nvim-treesitter
                              :build ":TSUpdate"
                              :config (fn [_ opts]
                                        (tset (require :nvim-treesitter.install)
                                              :prefer_git true)
                                        ((. (require :nvim-treesitter.configs)
                                            :setup) opts))
                              :opts {:auto_install true
                                     :ensure_installed [:bash
                                                        :c
                                                        :diff
                                                        :html
                                                        :lua
                                                        :luadoc
                                                        :java
                                                        :typescript
                                                        :markdown
                                                        :vim
                                                        :vimdoc]
                                     :highlight {:additional_vim_regex_highlighting [:ruby]
                                                 :enable true}
                                     :indent {:disable [:ruby] :enable true}}}
