(local uu (require :cal.util))

(vim.keymap.set :n :<leader>lr :<cmd>LookoutReview<CR>
                {:desc "Lookout Review diff against HEAD"})

(vim.keymap.set :n :<leader>lc :<cmd>LookoutClear<CR>
                {:desc "Lookout Clear virtual diffs"})

[(uu.tx :lookout.nvim {:dir "~/src/personal/lookout.nvim" :opts {}})]
