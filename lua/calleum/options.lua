-- Set highlight on search
vim.o.hlsearch = true
-- Set tab width
vim.o.autoindent = true
-- Show jump numbers
vim.o.relativenumber = true
 vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
-- Always have 10 lines below the cursor
vim.o.scrolloff = 10
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
-- Set colorscheme 
vim.o.termguicolors = true
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = {'help', 'packer'}
vim.g.indent_blankline_buftype_exclude = {'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
-- Remap space as leader key
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.mkdp_echo_preview_url = 1
vim.g.vimtex_view_method = 'zathura'
