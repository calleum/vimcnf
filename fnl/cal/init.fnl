(local vim _G.vim)
(local uu (require :cal.util))

(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(set vim.g.have_nerd_font false)

(fn setup-options []
  (set vim.g.loaded_perl_provider 0)
  (set vim.g.loaded_ruby_provider 0)
  (let [options {:number true
                 :mouse :a
                 :showmode false
                 :clipboard :unnamedplus
                 :breakindent true
                 :undofile true
                 :ignorecase true
                 :smartcase true
                 :signcolumn :yes
                 :updatetime 250
                 :timeoutlen 300
                 :splitright true
                 :splitbelow true
                 :list true
                 :relativenumber true
                 :listchars {:nbsp "␣" :tab "» " :trail "·"}
                 :inccommand :split
                 :cursorline true
                 :scrolloff 10
                 :hlsearch true}]
    (each [name val (pairs options)]
      (tset vim.opt name val)))
  (set vim.o.exrc true)
  (set vim.o.secure true)
  (vim.opt.diffopt:append "algorithm:patience")
  (vim.opt.diffopt:append :indent-heuristic)
  (set vim.g.guicursor ""))

(fn setup-keymaps []
  (let [maps [[:n :<Esc> :<cmd>nohlsearch<CR> "Clear search highlight"]
              [:n "[d" vim.diagnostic.goto_prev "Go to previous diagnostic"]
              [:n "]d" vim.diagnostic.goto_next "Go to next diagnostic"]
              [:n :<leader>e vim.diagnostic.open_float "Show diagnostic error"]
              [:n :<leader>q vim.diagnostic.setloclist "Open diagnostic quickfix"]
              [:t :<Esc><Esc> "<C-\\><C-n>" "Exit terminal mode"]
              [:n :<C-h> :<C-w><C-h> "Focus left window"]
              [:n :<C-l> :<C-w><C-l> "Focus right window"]
              [:n :<C-j> :<C-w><C-j> "Focus lower window"]
              [:n :<C-k> :<C-w><C-k> "Focus upper window"]
              [:n :<leader>cp #(vim.fn.setreg "+" (vim.fn.expand "%:p")) "Copy file path"]
              [:n :n :nzz "Center next search"]
              [:n :N :Nzz "Center prev search"]
              [:n "*" :*zz "Center * search"]
              [:n "#" "#zz" "Center # search"]
              [:n :g* :g*zz "Center g* search"]
              [:n "/" "/\\v" "Search with very magic"]]]
    (each [_ [mode lhs rhs desc] (ipairs maps)]
      (vim.keymap.set mode lhs rhs {:desc desc}))))

(fn setup-autocommands []
  (vim.api.nvim_create_autocmd :TextYankPost
                               {:callback #(vim.highlight.on_yank)
                                :desc "Highlight when yanking text"
                                :group (vim.api.nvim_create_augroup :highlight-yank {:clear true})})

  (let [ft-configs [[:gitcommit 72 73]
                    [:tex 80 81]
                    [:text 90 90]
                    [:markdown 90 90]]]
    (each [_ [ft tw cc] (ipairs ft-configs)]
      (vim.api.nvim_create_autocmd :FileType
                                   {:pattern ft
                                    :callback (fn []
                                                (set vim.opt_local.spell true)
                                                (set vim.opt_local.textwidth tw)
                                                (set vim.opt_local.colorcolumn (tostring cc)))})))

  (vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                               {:pattern :/tmp/mutt*
                                :callback #(set vim.bo.filetype :mail)})

  (vim.api.nvim_create_autocmd :FileType
                               {:pattern :mail
                                :callback (fn []
                                            (set vim.opt_local.spell true)
                                            (set vim.opt_local.textwidth 72)
                                            (set vim.opt_local.colorcolumn :73)
                                            (set vim.opt_local.formatoptions
                                                 (.. vim.opt_local.formatoptions._value :w)))}))

(fn setup-lazy []
  (let [lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)]
    (when (not (vim.uv.fs_stat lazypath))
      (vim.fn.system [:git :clone "--filter=blob:none" :--branch=stable
                      "https://github.com/folke/lazy.nvim.git" lazypath]))
    (vim.opt.rtp:prepend lazypath)
    ((. (require :lazy) :setup) 
     [(uu.tx :folke/todo-comments.nvim {:dependencies [:nvim-lua/plenary.nvim] :opts {}})
      (uu.tx :tpope/vim-sleuth)
      (uu.tx :tpope/vim-fugitive)
      (uu.tx :tpope/vim-abolish)
      (uu.tx :Olical/nfnl)
      (uu.tx :isobit/vim-caddyfile)
      (uu.tx :numToStr/Comment.nvim {:opts {}})
      (uu.tx :folke/tokyonight.nvim
             {:init (fn []
                      (vim.cmd.colorscheme :tokyonight-night)
                      (vim.cmd.hi "Comment gui=none")
                      (let [clear {:bg :NONE :fg :NONE}]
                        (vim.api.nvim_set_hl 0 :TermCursor clear)
                        (vim.api.nvim_set_hl 0 :TermCursorNC clear)))
              :priority 1000})
      {:import :cal.plugin}]
     {:dev {:path "~/src/calleum" :patterns [:calleum] :fallback true}
      :rocks {:enabled false}})))

;; --- Execute ---

(setup-options)
(setup-keymaps)
(setup-autocommands)
(setup-lazy)

;; Helm / Filetype logic
(vim.treesitter.query.add_directive :inject-go-tmpl!
                                    (fn [_ _ _ _ metadata]
                                      (set metadata.injection.language :yaml))
                                    {})

(vim.filetype.add {:pattern {".*helm/.*/.*/templates/.*%.tpl" :helm
                             ".*helm/.*/.*/templates/.*%.ya?ml" :helm
                             ".*chart/.*/templates/.*%.ya?ml" :helm
                             "helmfile.*%.ya?ml" :helm}
                   :extension {:yml :yaml :nft :nftables}})
