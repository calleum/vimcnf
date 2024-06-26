(local uu (require :cal.util))
(local nvim (uu.autoload :aniseed.nvim))

(nvim.set_keymap :n :<leader>ut ":UndotreeShow<cr>:UndotreeFocus<cr>"
                 {:noremap true :silent true})
