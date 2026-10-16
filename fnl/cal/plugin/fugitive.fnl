(local uu (require :cal.util))

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
        args [:Git :difftool]]
    (when files-only (table.insert args :--name-only))
    (table.insert args :origin/HEAD...HEAD)
    (table.insert args :--)
    (each [_ pathspec (ipairs pathspecs)]
      (table.insert args (vim.fn.shellescape pathspec)))
    (vim.cmd (table.concat args " "))
    (vim.cmd :copen)))

[(uu.tx :tpope/vim-fugitive
        {:lazy false
         :keys [(uu.tx :<leader>sq #(review-quickfix true)
                       {:desc "Quickfix changed files (exclude locks/generated)"})
                (uu.tx :<leader>sQ #(review-quickfix false)
                       {:desc "Quickfix changed hunks (exclude locks/generated)"})]})]
