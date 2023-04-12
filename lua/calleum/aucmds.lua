-- auto commands

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
    { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- set .rkt files to ft=racket to ignore the #lang tag and use treesitter 
vim.cmd [[autocmd BufEnter *.rkt set ft=racket]]
vim.cmd [[autocmd BufEnter *.scrbl set ft=racket]]
