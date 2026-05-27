(local uu (require :cal.util))

(vim.keymap.set :n :<leader>dvh #(vim.cmd "DiffviewOpen origin/HEAD") {})
(vim.keymap.set :n :<leader>dvm #(vim.cmd "DiffviewOpen origin/main") {})
(vim.keymap.set :n :<leader>dvc #(vim.cmd :DiffviewClose) {})
(vim.keymap.set :n :<leader>dvt #(vim.cmd :DiffviewToggle) {})

[(uu.tx :dlyongemallo/diffview.nvim)]
