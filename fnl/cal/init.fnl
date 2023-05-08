(module cal.init
  {autoload {plugin cal.plugin
             nvim aniseed.nvim
             }})

;;; Introduction

;; Aniseed compiles this (and all other Fennel files under fnl) into the lua
;; directory. The init.lua file is configured to load this file when ready.

;; We'll use modules, macros and functions to define our configuration and
;; required plugins. We can use Aniseed to evaluate code as we edit it or just
;; restart Neovim.

;; You can learn all about Conjure and how to evaluate things by executing
;; :ConjureSchool in your Neovim. This will launch an interactive tutorial.

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)
(set nvim.o.hlsearch true)
(set nvim.o.autoindent true)
(set nvim.o.relativenumber true)
(set nvim.o.expandtab true)
(set nvim.o.scrolloff 10)
(set nvim.wo.number true)
(set nvim.o.breakindent true)
(set nvim.o.undofile true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.updatetime 250)
(set nvim.wo.signcolumn :yes)

; (nvim.ex.set :spell)
(nvim.ex.set :list)


;;; Mappings
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader " ")
(set nvim.g.indent_blankline_char "┊")

;;; Generic configuration
(require :cal.options)
(require :cal.keymap)



;;; Plugins

;; Run script/sync.sh to update, install and clean your plugins.
;; Packer configuration format: https://github.com/wbthomason/packer.nvim
(plugin.use
  :Olical/aniseed {}
  :Olical/conjure {:mod :conjure}
  :Olical/nvim-local-fennel {}
  :PaterJason/cmp-conjure {}
  :PeterRincker/vim-argumentative {}
  :simrat39/rust-tools.nvim {:mod :rust}
  :airblade/vim-gitgutter {}
  :lukas-reineke/indent-blankline.nvim {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :folke/which-key.nvim {:mod :which-key}
  :danymat/neogen {:mod :neogen}
  :lervag/vimtex {}
  :wlangstroth/vim-racket {}
  :ggandor/lightspeed.nvim {}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-path {}
  :hrsh7th/nvim-cmp {:mod :cmp}
  :L3MON4D3/LuaSnip {:requires [[:saadparwaiz1/cmp_luasnip] [:rafamadriz/friendly-snippets]]}
  ; :jiangmiao/auto-pairs {:mod :auto-pairs}
  :lewis6991/impatient.nvim {}
  :ethanholz/nvim-lastplace {}
  :marko-cerovac/material.nvim {:mod :material}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :nvim-lualine/lualine.nvim {:mod :lualine}
  :nvim-telescope/telescope-ui-select.nvim {}
  :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]}
  :radenling/vim-dispatch-neovim {}
  :numToStr/Comment.nvim {}
  :tpope/vim-abolish {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  ; :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :nvim-treesitter/playground {}
  :nvim-treesitter/nvim-treesitter-textobjects {}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :wbthomason/packer.nvim {}
  )
