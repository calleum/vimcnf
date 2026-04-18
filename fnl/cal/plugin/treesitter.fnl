(local uu (require :cal.util))

[(uu.tx :nvim-treesitter/nvim-treesitter
        {:branch :main
         :build ":TSUpdate"
         :config (fn [_ opts]
                   (tset (require :nvim-treesitter.install) :prefer_git true)
                   (let [ts (require :nvim-treesitter)]
                     (ts.setup opts)
                     (when opts.ensure_installed
                       (ts.install opts.ensure_installed))

                     ;; Enable highlighting and indent for all installed parsers
                     ;; This is the modern way to enable these features in the main branch
                     (vim.api.nvim_create_autocmd :FileType
                                                  {:callback (fn [args]
                                                               (local bufnr args.buf)
                                                               (local ft (vim.api.nvim_get_option_value :filetype {:buf bufnr}))
                                                               (local lang (vim.treesitter.language.get_lang ft))
                                                               (when (and lang (pcall vim.treesitter.start bufnr lang))
                                                                 (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))
                                                   :group (vim.api.nvim_create_augroup :treesitter-setup {:clear true})})))
         :opts {:auto_install true
                :ensure_installed [:bash
                                   :c
                                   :diff
                                   :html
                                   :lua
                                   :luadoc
                                   :javascript
                                   :typescript
                                   :vim
                                   :vimdoc]}})
  (uu.tx :nvim-treesitter/nvim-treesitter-context
         {
          :config (fn [_ opts]
                    ((. (require :treesitter-context) :setup) opts))
          :opts {:exclude_ftypes [:markdown]
                 :on_attach (fn [buf]
                              (not= (. vim.bo buf :filetype) :markdown))}})]
