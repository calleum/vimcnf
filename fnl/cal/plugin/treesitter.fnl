(local uu (require :cal.util))

(fn setup-treesitter-highlights []
  "Configures modern Treesitter-based highlighting and indentation."
  (vim.api.nvim_create_autocmd :FileType
                               {:callback (fn [{:buf bufnr}]
                                            (let [ft (vim.api.nvim_get_option_value :filetype
                                                                                    {:buf bufnr})
                                                  lang (vim.treesitter.language.get_lang ft)]
                                              (when (and lang
                                                         (pcall vim.treesitter.start
                                                                bufnr lang))
                                                (set vim.bo.indentexpr
                                                     "v:lua.require'nvim-treesitter'.indentexpr()"))))
                                :group (vim.api.nvim_create_augroup :treesitter-setup
                                                                    {:clear true})}))

[(uu.tx :nvim-treesitter/nvim-treesitter
        {:branch :main
         :build ":TSUpdate"
         :opts {:auto_install true
                :ensure_installed [:bash
                                   :c
                                   :diff
                                   :git_config
                                   :git_rebase
                                   :gitcommit
                                   :fish
                                   :html
                                   :lua
                                   :rust
                                   :fennel
                                   :python
                                   :luadoc
                                   :javascript
                                   :typescript
                                   :vim
                                   :vimdoc]}
         :config (fn [_ opts]
                   (tset (require :nvim-treesitter.install) :prefer_git true)
                   (let [ts (require :nvim-treesitter)]
                     (when ts.setup (ts.setup opts))
                     (when (and opts.ensure_installed ts.install)
                       (ts.install opts.ensure_installed))
                     (setup-treesitter-highlights)))})
 (uu.tx :nvim-treesitter/nvim-treesitter-context
        {:opts {:exclude_ftypes [:markdown]
                :on_attach (fn [buf] (not= (. vim.bo buf :filetype) :markdown))}})]
