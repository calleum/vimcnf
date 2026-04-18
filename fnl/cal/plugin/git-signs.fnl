(local uu (require :cal.util))

(fn on-attach [bufnr]
  (let [gs (require :gitsigns)
        maps [[:n "]c" #(if vim.wo.diff (vim.cmd.normal {1 "]c" :bang true}) (gs.nav_hunk :next)) "Next Hunk"]
              [:n "[c" #(if vim.wo.diff (vim.cmd.normal {1 "[c" :bang true}) (gs.nav_hunk :prev)) "Prev Hunk"]
              [:n :<leader>hs gs.stage_hunk "Stage Hunk"]
              [:n :<leader>hr gs.reset_hunk "Reset Hunk"]
              [:v :<leader>hs #(gs.stage_hunk [(vim.fn.line ".") (vim.fn.line :v)]) "Stage Hunk"]
              [:v :<leader>hr #(gs.reset_hunk [(vim.fn.line ".") (vim.fn.line :v)]) "Reset Hunk"]
              [:n :<leader>hS gs.stage_buffer "Stage Buffer"]
              [:n :<leader>hu gs.undo_stage_hunk "Undo Stage Hunk"]
              [:n :<leader>hR gs.reset_buffer "Reset Buffer"]
              [:n :<leader>hp gs.preview_hunk "Preview Hunk"]
              [:n :<leader>hb #(gs.blame_line {:full true}) "Blame Line"]
              [:n :<leader>tb gs.toggle_current_line_blame "Toggle Line Blame"]
              [:n :<leader>hd gs.diffthis "Diff This"]
              [:n :<leader>hD #(gs.diffthis "~") "Diff This ~"]
              [:n :<leader>td gs.toggle_deleted "Toggle Deleted"]
              [[:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>" "Select Hunk"]]]
    (each [_ [mode lhs rhs desc] (ipairs maps)]
      (vim.keymap.set mode lhs rhs {:buffer bufnr :desc desc}))))

[(uu.tx :lewis6991/gitsigns.nvim
        {:opts {:on_attach on-attach
                :signs {:add {:text "+"}
                        :change {:text "~"}
                        :changedelete {:text "~"}
                        :delete {:text "_"}
                        :topdelete {:text "‾"}}}})]
