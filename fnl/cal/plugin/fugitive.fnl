(local uu (require :cal.util))

(fn leave-review []
  (let [gs (require :gitsigns)]
    (gs.change_base nil true)
    (gs.toggle_linehl false)
    (vim.notify "Git review mode off")))

(fn review-quickfix [files-only]
  ;; Attribute values can be either a bare flag or the string "true".
  (let [pathspecs [":(top)"
                   ":(top,exclude,glob)**/*.lock"
                   ":(top,exclude,glob)**/*-lock.json"
                   ":(top,exclude,glob)**/pnpm-lock.yaml"
                   ":(top,exclude,glob)**/bun.lockb"
                   ":(top,exclude,glob)**/go.sum"
                   ":(top,exclude,attr:linguist-generated)"
                   ":(top,exclude,attr:linguist-generated=true)"]
        args [:Git :difftool]
        root (vim.fn.FugitiveWorkTree)
        base (vim.trim (vim.fn.system [:git :-C root :merge-base :origin/HEAD :HEAD]))]
    (if (not= vim.v.shell_error 0)
        (vim.notify (.. "Cannot start Git review: " base) vim.log.levels.ERROR)
        (do
          (when files-only (table.insert args :--name-only))
          ;; A single revision targets working-tree files, not fugitive:// blobs.
          ;; This also includes local edits so quickfix and Gitsigns agree.
          (table.insert args base)
          (table.insert args :--)
          (each [_ pathspec (ipairs pathspecs)]
            (table.insert args (vim.fn.shellescape pathspec)))
          (let [gs (require :gitsigns)]
            (gs.change_base base true)
            (gs.toggle_linehl true))
          (vim.cmd (table.concat args " "))
          (vim.cmd :copen)))))

[(uu.tx :tpope/vim-fugitive
        {:lazy false
         :dependencies [:lewis6991/gitsigns.nvim]
         :keys [(uu.tx :<leader>sQ #(review-quickfix true)
                       {:desc "Quickfix changed files (exclude locks/generated)"})
                (uu.tx :<leader>sq #(review-quickfix false)
                       {:desc "Quickfix changed hunks (exclude locks/generated)"})
                (uu.tx :<leader>se leave-review
                       {:desc "Exit Git review mode"})]})]
