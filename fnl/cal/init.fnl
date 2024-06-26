(local vim _G.vim)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(set vim.g.have_nerd_font true)
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
(set vim.opt.listchars {:nbsp "␣" :tab "» " :trail "·"})
(set vim.opt.inccommand :split)
(set vim.opt.cursorline true)
(set vim.opt.scrolloff 10)
(set vim.opt.hlsearch true)

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
(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (fn [] (vim.highlight.on_yank))
                              :desc "Highlight when yanking (copying) text"
                              :group (vim.api.nvim_create_augroup :kickstart-highlight-yank
                                                                  {:clear true})})
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
((. (require :lazy) :setup) {:checker {:enabled true}
                             :install {:colorscheme [:habamax]}
                             :spec [{:import :plugins.config}]})
((. (require :lazy) :setup) [:tpope/vim-sleuth
                             {1 :numToStr/Comment.nvim :opts {}}
                             {1 :lewis6991/gitsigns.nvim
                              :opts {:signs {:add {:text "+"}
                                             :change {:text "~"}
                                             :changedelete {:text "~"}
                                             :delete {:text "_"}
                                             :topdelete {:text "‾"}}}}
                             {1 :folke/tokyonight.nvim
                              :init (fn []
                                      (vim.cmd.colorscheme :tokyonight-night)
                                      (vim.cmd.hi "Comment gui=none"))
                              :priority 1000}
                             {1 :folke/todo-comments.nvim
                              :dependencies [:nvim-lua/plenary.nvim]
                              :event :VimEnter
                              :opts {:signs false}}
                             {1 :echasnovski/mini.nvim
                              :config (fn []
                                        ((. (require :mini.ai) :setup) {:n_lines 500})
                                        ((. (require :mini.surround) :setup))
                                        (local statusline
                                               (require :mini.statusline))
                                        (statusline.setup {:use_icons vim.g.have_nerd_font})
                                        (set statusline.section_location
                                             (fn [] "%2l:%-2v")))}
                             ]
                            {:ui {:icons (or (and vim.g.have_nerd_font {})
                                             {:cmd "⌘"
                                              :config "🛠"
                                              :event "📅"
                                              :ft "📂"
                                              :init "⚙"
                                              :keys "🗝"
                                              :lazy "💤 "
                                              :plugin "🔌"
                                              :require "🌙"
                                              :runtime "💻"
                                              :source "📄"
                                              :start "🚀"
                                              :task "📌"})}})
