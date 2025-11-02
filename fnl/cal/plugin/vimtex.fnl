(local vim _G.vim)
(local uu (require :cal.util))

[(uu.tx :lervag/vimtex
        {:ft :tex
         :config (fn a []
                   (vim.keymap.set :n :<leader>ll
                                   (fn [] (vim.cmd :VimtexCompile)))
                   (set vim.g.vimtex_imaps_enabled 0)
                   (set vim.g.tex_flavor :latex)
                   (set vim.g.vimtex_enabled 1)
                   (set vim.g.vimtex_syntax_enabled 0)
                   (set vim.g.vimtex_compiler_method :latexmk)
                   (set vim.g.vimtex_compiler_latexmk
                        {:options [:-pdf
                                   :-interaction=nonstopmode
                                   :--shell-escape
                                   :-synctex=1]
                         :out_dir :build}) ; (set vim.g.vimtex_quickfix_mode 1)
                   (set vim.g.vimtex_quickfix_enabled 0)
                   (set vim.g.vimtex_delim_toggle_mod_list
                        [["\\bigl" "\\bigr"]
                         ["\\Bigl" "\\Bigr"]
                         ["\\biggl" "\\biggr"]
                         ["\\Biggl" "\\Biggr"]])
                   (when (= (vim.fn.has :mac) 1)
                     (set vim.g.vimtex_view_method :skim)
                     (set vim.g.vimtex_view_skim_sync 1)
                     (set vim.g.vimtex_view_skim_activate 1)))})]
