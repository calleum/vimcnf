(module cal.init
  {autoload {plugin cal.plugin
             nvim aniseed.nvim}})

;;; Introduction

;; Aniseed compiles this (and all other Fennel files under fnl) into the lua
;; directory. The init.lua file is configured to load this file when ready.

;; We'll use modules, macros and functions to define our configuration and
;; required plugins. We can use Aniseed to evaluate code as we edit it or just
;; restart Neovim.

;; You can learn all about Conjure and how to evaluate things by executing
;; :ConjureSchool in your Neovim. This will launch an interactive tutorial.


;;; Generic configuration

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.hlsearch true)
(set nvim.o.relativenumber true)
(set nvim.o.breakindent true)
(set nvim.o.autoindent true)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.completeopt "menuone,noselect")
(set nvim.o.inccommand :split)
(set nvim.o.shiftwidth 4)
(set nvim.o.tabstop 4)
(set nvim.o.softtabstop 4)
(set nvim.o.expandtab true)
(set nvim.o.scrolloff 10)
(set nvim.o.undofile true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.wo.number true)
(set nvim.wo.signcolumn :yes)

(nvim.ex.set :spell)
(nvim.ex.set :list)


;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(set nvim.g.indent_blankline_char "┊")
(set nvim.g.indent_blankline_filetype_exclude [:help :packer])
(set nvim.g.indent_blankline_buftype_exclude [:terminal :nofile])
(set nvim.g.vimtex_view_method :zathura)
(set nvim.g.indent_blankline_char_highlight :LineNr)
(set nvim.g.indent_blankline_show_trailing_blankline_indent false)

;;; Plugins

;; Run script/sync.sh to update, install and clean your plugins.
;; Packer configuration format: https://github.com/wbthomason/packer.nvim
(plugin.use
  :Olical/aniseed {}
  :Olical/conjure {}
  :Olical/nvim-local-fennel {}
  :PaterJason/cmp-conjure {}
  :PeterRincker/vim-argumentative {}
  :simrat39/rust-tools.nvim {:mod :rust}
  :airblade/vim-gitgutter {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :folke/which-key.nvim {:mod :which-key}
  :danymat/neogen {}
  :lervag/vimtex {}
  :wlangstroth/vim-racket {}
  :ggandor/lightspeed.nvim {}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-path {}
  :hrsh7th/cmp-nvim-lsp-signature-help
  :L3MON4D3/LuaSnip {:requires [[:saadparwaiz1/cmp_luasnip] [:rafamadriz/friendly-snippets]]}
  :hrsh7th/nvim-cmp {:mod :cmp}
  :jiangmiao/auto-pairs {:mod :auto-pairs}
  :lewis6991/impatient.nvim {}
  :liuchengxu/vim-better-default {:mod :better-default}
  :marko-cerovac/material.nvim {:mod :material}
  :folke/tokyonight.nvim {}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :j-hui/fidget.nvim {}
  :nvim-lualine/lualine.nvim {:mod :lualine :requires [[:kyazdani42/nvim-web-devicons]]}
  :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]}
  :nvim-telescope/telescope-ui-select.nvim {}
  :lewis6991/gitsigns.nvim {:requires [[:nvim-lua/plenary.nvim]]}
  :nvim-treesitter/nvim-treesitter-refactor
  :nvim-treesitter/nvim-treesitter {:mod :treesitter}
  :radenling/vim-dispatch-neovim {}
  :numToStr/Comment.nvim {}
  :lukas-reineke/indent-blankline.nvim {}
  :tpope/vim-abolish {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :ethanholz/nvim-lastplace {}
  :wbthomason/packer.nvim {}
  )

