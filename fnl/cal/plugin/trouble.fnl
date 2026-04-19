(local uu (require :cal.util))

[(uu.tx :folke/trouble.nvim
        {:cmd :Trouble
         :opts {:auto_preview false :focus true}
         :keys [(uu.tx :<leader>xx "<cmd>Trouble diagnostics toggle<cr>"
                       {:desc "Diagnostics (Trouble)"})
                (uu.tx :<leader>xX
                       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
                       {:desc "Buffer Diagnostics (Trouble)"})
                (uu.tx :<leader>cs
                       "<cmd>Trouble symbols toggle focus=false<cr>"
                       {:desc "Symbols (Trouble)"})
                (uu.tx :<leader>cl
                       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>"
                       {:desc "LSP Definitions / references / ... (Trouble)"})
                (uu.tx :<leader>xL "<cmd>Trouble loclist toggle<cr>"
                       {:desc "Location List (Trouble)"})
                (uu.tx :<leader>xQ "<cmd>Trouble qflist toggle<cr>"
                       {:desc "Quickfix List (Trouble)"})]})]
