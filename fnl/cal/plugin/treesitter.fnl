(local uu (require :cal.util))

[(uu.tx :nvim-treesitter/nvim-treesitter
        {:build ":TSUpdate"
         :dependencies [:nvim-treesitter/nvim-treesitter-refactor]
         :config (fn [_ opts]
                   (tset (require :nvim-treesitter.install) :prefer_git true)
                   ((. (require :nvim-treesitter.configs) :setup) opts))
         :opts {:auto_install true
                :refactor {:smart_rename {:enable true
                                          :keymaps {:smart_rename :grr}}}
                :ensure_installed [:bash
                                   :c
                                   :diff
                                   :html
                                   :lua
                                   :luadoc
                                   :java
                                   :javascript
                                   :typescript
                                   :markdown
                                   :vim
                                   :vimdoc]
                :highlight {:additional_vim_regex_highlighting [:ruby]
                            :enable true}
                :indent {:disable [:ruby] :enable true}}})
 (uu.tx :nvim-treesitter/nvim-treesitter-textobjects
        {:dependencies [:nvim-treesitter/nvim-treesitter]})
 (uu.tx :nvim-treesitter/nvim-treesitter-context
        {:dependencies [:nvim-treesitter/nvim-treesitter]})]
