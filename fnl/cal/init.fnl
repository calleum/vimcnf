(local vim _G.vim)
(local uu (require :cal.util))

(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(set vim.g.have_nerd_font false)
(set vim.opt.number true)
(set vim.opt.mouse :a)
(set vim.opt.showmode false)
(set vim.opt.clipboard :unnamedplus)
(set vim.opt.breakindent true)
(set vim.opt.undofile true)
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.signcolumn :yes)
(set vim.opt.updatetime 250)
(set vim.opt.timeoutlen 300)
(set vim.opt.splitright true)
(set vim.opt.splitbelow true)
(set vim.opt.list true)
(set vim.opt.relativenumber true)
(set vim.opt.listchars {:nbsp "␣" :tab "» " :trail "·"})
(set vim.opt.inccommand :split)
(set vim.opt.cursorline true)
(set vim.opt.scrolloff 10)
(set vim.opt.hlsearch true)
(set vim.o.exrc true)
(set vim.o.secure true)
(vim.opt.diffopt:append "algorithm:patience")
(vim.opt.diffopt:append :indent-heuristic)
(set vim.g.guicursor "")

(vim.keymap.set :n :<Esc> :<cmd>nohlsearch<CR>)
(vim.keymap.set :n "[d" vim.diagnostic.goto_prev
                {:desc "Go to previous [D]iagnostic message"})

(vim.keymap.set :n "]d" vim.diagnostic.goto_next
                {:desc "Go to next [D]iagnostic message"})

(vim.keymap.set :n :<leader>e vim.diagnostic.open_float
                {:desc "Show diagnostic [E]rror messages"})

(vim.keymap.set :n :<leader>q vim.diagnostic.setloclist
                {:desc "Open diagnostic [Q]uickfix list"})

(vim.keymap.set :t :<Esc><Esc> "<C-\\><C-n>" {:desc "Exit terminal mode"})
(vim.keymap.set :n :<C-h> :<C-w><C-h> {:desc "Move focus to the left window"})
(vim.keymap.set :n :<C-l> :<C-w><C-l> {:desc "Move focus to the right window"})
(vim.keymap.set :n :<C-j> :<C-w><C-j> {:desc "Move focus to the lower window"})
(vim.keymap.set :n :<C-k> :<C-w><C-k> {:desc "Move focus to the upper window"})
(vim.keymap.set :n :<leader>cp
                (fn []
                  (vim.fn.setreg "+" (vim.fn.expand "%:p"))))

(vim.keymap.set :n :n :nzz {:noremap true :silent true})
(vim.keymap.set :n :N :Nzz {:noremap true :silent true})
(vim.keymap.set :n "*" :*zz {:noremap true :silent true})
(vim.keymap.set :n "#" "#zz" {:noremap true :silent true})
(vim.keymap.set :n :g* :g*zz {:noremap true :silent true})
(vim.keymap.set :n "/" "/\\v" {:noremap true})

(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (fn [] (vim.highlight.on_yank))
                              :desc "Highlight when yanking (copying) text"
                              :group (vim.api.nvim_create_augroup :kickstart-highlight-yank
                                                                  {:clear true})})

(vim.treesitter.query.add_directive :inject-go-tmpl!
                                    (fn [metadata]
                                      (tset metadata :injection.language :yaml))
                                    {})

(vim.filetype.add {:pattern {".*helm/.*/.*/templates/.*%.tpl" :helm
                             ".*helm/.*/.*/templates/.*%.ya?ml" :helm
                             ".*chart/.*/templates/.*%.ya?ml" :helm
                             "helmfile.*%.ya?ml" :helm}
                   :extension {:yml :yaml :nft :nftables}})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :gitcommit
                              :callback (fn []
                                          (set vim.opt_local.spell true)
                                          (set vim.opt_local.textwidth 72)
                                          (set vim.opt_local.colorcolumn :73))})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :tex
                              :callback (fn []
                                          (set vim.opt_local.spell true)
                                          (set vim.opt_local.textwidth 80)
                                          (set vim.opt_local.colorcolumn :81))})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :text
                              :callback (fn []
                                          (set vim.opt_local.spell true)
                                          (set vim.opt_local.textwidth 90)
                                          (set vim.opt_local.colorcolumn :90))})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :markdown
                              :callback (fn []
                                          (set vim.opt_local.spell true)
                                          (set vim.opt_local.textwidth 90)
                                          (set vim.opt_local.colorcolumn :90))})

(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :/tmp/mutt*
                              :callback (fn []
                                          (set vim.bo.filetype :mail))})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :mail
                              :callback (fn []
                                          (set vim.opt_local.spell true)
                                          (set vim.opt_local.textwidth 72)
                                          (set vim.opt_local.colorcolumn :73)
                                          (set vim.opt_local.formatoptions
                                               (.. vim.opt_local.formatoptions._value
                                                   :w)))})

(local lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(when (not (vim.loop.fs_stat lazypath))
  (local lazyrepo "https://github.com/folke/lazy.nvim.git")
  (vim.fn.system [:git
                  :clone
                  "--filter=blob:none"
                  :--branch=stable
                  lazyrepo
                  lazypath]))

(vim.opt.rtp:prepend lazypath)

((. (require :lazy) :setup) [(uu.tx :folke/todo-comments.nvim
                                    {:dependencies [:nvim-lua/plenary.nvim]
                                     :opts {}})
                             (uu.tx :tpope/vim-sleuth)
                             (uu.tx :tpope/vim-fugitive)
                             (uu.tx :tpope/vim-abolish)
                             (uu.tx :tpope/vim-surround)
                             (uu.tx :Olical/nfnl)
                             (uu.tx :mrcjkb/nvim-lastplace)
                             (uu.tx :isobit/vim-caddyfile)
                             (uu.tx :numToStr/Comment.nvim {:opts {}})
                             (uu.tx :folke/tokyonight.nvim
                                    {:init (fn []
                                             (vim.cmd.colorscheme :tokyonight-night)
                                             (vim.cmd.hi "Comment gui=none")
                                             (vim.api.nvim_set_hl 0 :TermCursor
                                                                  {:bg :NONE
                                                                   :fg :NONE})
                                             (vim.api.nvim_set_hl 0
                                                                  :TermCursorNC
                                                                  {:bg :NONE
                                                                   :fg :NONE}))
                                     :priority 1000})
                             (uu.tx :rcarriga/nvim-notify)
                             (uu.tx :mrded/nvim-lsp-notify
                                    {:config (fn []
                                               ((. (require :lsp-notify) :setup) {:notify (require :notify)}))})
                             {:import :cal.plugin}]
                            {:dev {:path "~/src/calleum"
                                   :patterns [:calleum]
                                   :fallback true}})
