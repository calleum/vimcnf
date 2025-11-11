(local vim _G.vim)
(local fun (require :cal.util.vendor.fun))

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
(set vim.opt.listchars {:nbsp "␣" :tab "» " :trail "·"})
(set vim.opt.inccommand :split)
(set vim.opt.cursorline true)
(set vim.opt.scrolloff 10)
(set vim.opt.hlsearch true)
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
(vim.api.nvim_create_autocmd :TextYankPost
                             {:callback (fn [] (vim.highlight.on_yank))
                              :desc "Highlight when yanking (copying) text"
                              :group (vim.api.nvim_create_augroup :kickstart-highlight-yank
                                                                  {:clear true})})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:callback (fn []
                                          (when (= vim.bo.filetype :java)
                                            (vim.cmd "%s/\\s\\+$//e")))
                              :pattern "*"})

(vim.cmd "autocmd BufNewFile,BufRead *.jenkinsfile set filetype=groovy")
;
; (vim.api.nvim_create_augroup :filetypedetect {:clear true})
; (vim.api.nvim_create_autocmd [:BufNewFile :BufRead]
;                              {:callback (fn []
;                                           (when (> (vim.fn.search "{{.+}}" :nw)
;                                                    0)
;                                             (set vim.bo.filetype :gotmpl)))
;                               :group :filetypedetect
;                               :pattern :*.yml})

(vim.treesitter.query.add_directive :inject-go-tmpl!
                                    (fn [metadata]
                                      (tset metadata :injection.language :yaml))
                                    {})

(vim.treesitter.language.register :xml :jelly)

(vim.filetype.add {:pattern {".*helm/.*/.*/templates/.*%.tpl" :helm
                             ".*helm/.*/.*/templates/.*%.ya?ml" :helm
                             ".*chart/.*/templates/.*%.ya?ml" :helm
                             "helmfile.*%.ya?ml" :helm}
                   :extension {:yml :yaml :jelly :jelly}})

; (vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
;                              {:callback (fn []
;                                           (local filename (vim.fn.expand "%:t"))
;                                           (when (not (filename:match "%."))
;                                             (local lines
;                                                    (vim.api.nvim_buf_get_lines 0
;                                                                                0
;                                                                                1
;                                                                                false))
;                                             (each [_ line (ipairs lines)]
;                                               (local trimmed-line
;                                                      (line:match "^%s*(.-)%s*$"))
;                                               (when (or (= (trimmed-line:sub 1
;                                                                              10)
;                                                            "pipeline {")
;                                                         (= (trimmed-line:sub 1
;                                                                              9)
;                                                            "@Library("))
;                                                 (set vim.bo.filetype :groovy)
;                                                 (lua :break)))))
;                               :pattern "*"})

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

(fn last [xs]
  (fun.nth (fun.length xs) xs))

(fn tx [...]
  "Slightly nicer syntax for things like defining dependencies.
  Anything that relies on the {1 :foo :bar true} syntax can use this."
  (let [args [...]
        len (fun.length args)]
    (if (= :table (type (last args)))
        (fun.reduce (fn [acc n v]
                      (tset acc n v)
                      acc) (last args)
                    (fun.zip (fun.range 1 len) (fun.take (- len 1) args)))
        args)))

((. (require :lazy) :setup) [(tx :folke/todo-comments.nvim
                                 {; :main :todo-comments
                                  :dependencies [:nvim-lua/plenary.nvim]
                                  ; :event :VimEnter
                                  :opts {}})
                             (tx :tpope/vim-sleuth)
                             (tx :tpope/vim-fugitive)
                             (tx :tpope/vim-abolish)
                             (tx :tpope/vim-surround)
                             (tx :Olical/nfnl)
                             ; (tx :Olical/aniseed)
                             (tx :mrcjkb/nvim-lastplace)
                             ; (tx :calleum/pulse)
                             (tx :isobit/vim-caddyfile)
                             (tx :numToStr/Comment.nvim {:opts {}})
                             (tx :folke/tokyonight.nvim
                                 {:init (fn []
                                          (vim.cmd.colorscheme :tokyonight-night)
                                          (vim.cmd.hi "Comment gui=none"))
                                  :priority 1000})
                             (tx :rcarriga/nvim-notify)
                             (tx :mrded/nvim-lsp-notify
                                 {:config (fn []
                                            ((. (require :lsp-notify) :setup) {:notify (require :notify)}))})
                             (tx :ckipp01/nvim-jenkinsfile-linter
                                 {:ft [:jenkinsfile :groovy]})
                             {:import :cal.plugin}]
                            {:dev {:path "~/src/calleum"
                                   :patterns [:calleum]
                                   :fallback true}})

(vim.api.nvim_set_hl 0 "@jsni.java_call" {:link :Function})
