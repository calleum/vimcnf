{1 :lewis6991/gitsigns.nvim
 :opts {:signs {:add {:text "+"}
                :change {:text "~"}
                :changedelete {:text "~"}
                :delete {:text "_"}
                :topdelete {:text "‾"}}}
 :on_attach (fn [bufnr]
              (local gitsigns (require :gitsigns))

              (fn map [mode l r opts]
                (set-forcibly! opts (or opts {}))
                (set opts.buffer bufnr)
                (vim.keymap.set mode l r opts))

              (map :n "]c"
                   (fn []
                     (if vim.wo.diff
                         (vim.cmd.normal {1 "]c" :bang true})
                         (gitsigns.nav_hunk :next))))
              (map :n "[c"
                   (fn []
                     (if vim.wo.diff
                         (vim.cmd.normal {1 "[c" :bang true})
                         (gitsigns.nav_hunk :prev))))
              (map :n :<leader>hs gitsigns.stage_hunk)
              (map :n :<leader>hr gitsigns.reset_hunk)
              (map :v :<leader>hs
                   (fn []
                     (gitsigns.stage_hunk [(vim.fn.line ".") (vim.fn.line :v)])))
              (map :v :<leader>hr
                   (fn []
                     (gitsigns.reset_hunk [(vim.fn.line ".") (vim.fn.line :v)])))
              (map :n :<leader>hS gitsigns.stage_buffer)
              (map :n :<leader>hu gitsigns.undo_stage_hunk)
              (map :n :<leader>hR gitsigns.reset_buffer)
              (map :n :<leader>hp gitsigns.preview_hunk)
              (map :n :<leader>hb (fn [] (gitsigns.blame_line {:full true})))
              (map :n :<leader>tb gitsigns.toggle_current_line_blame)
              (map :n :<leader>hd gitsigns.diffthis)
              (map :n :<leader>hD (fn [] (gitsigns.diffthis "~")))
              (map :n :<leader>td gitsigns.toggle_deleted)
              (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>"))}
