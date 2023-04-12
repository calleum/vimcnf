-- file to install plugins
-- Install packer
local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
    install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = 'init.lua'
})

require('packer').startup(function(use)
    -- use 'lewis6991/impatient.nvim'
    use 'ethanholz/nvim-lastplace'
    use 'wbthomason/packer.nvim' -- Package manager
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'tpope/vim-abolish' -- crs, crc, crm, cru, cr-, cr. , cr<space>, crt
    use 'tpope/vim-surround' -- turn "this" into {this} easily
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines

    -- UI to select things (files, grep results, open buffers...)
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- lets go faster
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'nvim-telescope/telescope-dap.nvim'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use 'eddyekofo94/gruvbox-flat.nvim'
    use 'Mofiqul/dracula.nvim'
    use 'ishan9299/nvim-solarized-lua'
    use 'marko-cerovac/material.nvim'
    use 'folke/tokyonight.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- use 'arkav/lualine-lsp-progress'
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups
    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } } -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'martinda/Jenkinsfile-vim-syntax'
    use({
        'ckipp01/nvim-jenkinsfile-linter',
        requires = { "nvim-lua/plenary.nvim" }
    })
    use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    })
    -- use 'vimpostor/vim-lumen' -- switch between dark and lightmode based on darkman value
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-nvim-lua' } }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' } } -- Snippet Engine and Snippet Expansion

    -- use 'mfussenegger/nvim-jdtls'
    -- use { 'git@gitlab.com:schrieveslaach/nvim-jdtls-bundles', { run = './install-bundles.py --pde' },
    --     after = { 'nvim-treesitter' } }
    use 'simrat39/rust-tools.nvim'
    -- use 'tamago324/nlsp-settings.nvim'
    -- use 'mfussenegger/nvim-dap'
    use "danymat/neogen"
    use 'lervag/vimtex'
    -- use 'udalov/kotlin-vim'
    -- use 'Olical/conjure'
    use 'wlangstroth/vim-racket'
end)

-- require 'impatient'
require 'nvim-lastplace'.setup {}
require('Comment').setup()
require 'neogen'.setup({ enabled = true, snippet_engine = "luasnip" })
