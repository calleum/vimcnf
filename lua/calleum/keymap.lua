--============================================================================
-- TELESCOPE KEYMAPS
--============================================================================
local keymap = {}

local nmap_mi = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
end

local tnmap = function(keys, func, desc)
    if desc then
        desc = 'Telescope: ' .. desc
    end
    nmap_mi(keys, func, desc)
end

local tele = require('calleum.telescope')

tnmap('<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
tnmap('<leader><space>', require('telescope.builtin').buffers, '[ ] Find existing buffers')
tnmap('<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, '[/] Fuzzily search in current buffer]')

tnmap('<leader>sf', tele.project_files, '[S]earch [F]iles')
tnmap('<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
tnmap('<leader>sw', tele.grep, '[S]earch current [W]ord')
tnmap('<leader>sg', tele.live_grep, '[S]earch by [G]rep')
tnmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')
tnmap('<leader>fs', tele.find_sametype, '[F]ind files of [S]ame filetype')
tnmap('<leader>ai', tele.aws_infra_find, 'Find in [A]ws [I]nfrastructure')
tnmap('<leader>aj', tele.aws_jenkins_find, 'Find in [A]ws [J]enkins Pipeline')
tnmap('<leader>dev', tele.dev_files_find, 'Find in [A]ws [I]nfrastructure')
tnmap('<leader>mkn', tele.notes_find, 'Find in [A]ws [I]nfrastructure')
tnmap('<leader>qf', require('telescope.builtin').quickfix, 'Find in [A]ws [I]nfrastructure')
tnmap('<leader>sc', tele.config_find, '[S]earch neovim [C]onfiguration files')
tnmap('<leader>cd', vim.cmd('cd "%:p:h"'), '[C]hange [D]irectory to current file dir')
tnmap('<leader>st', require('telescope.builtin').tags, '[S]earch c[T]ags in project')
tnmap('<leader>sy', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[S]earch Dynamic Workspace S[Y]mbols')
nmap_mi('<leader>lj', require('jenkinsfile_linter').validate, '[L]int [J]enkinsfile')
nmap_mi('<leader>nd', require('neogen').generate, 'Generate [N]eogen [D]ocumentation Template')

--============================================================================
-- BUFFERWISE KEYMAPS
--============================================================================
-- nmap_mi('<leader>hh',
    -- function() vim.cmd("bprev" .. vim.v.count1) end, '[<leader>hh] Jump to Previous Buffer ')
-- nmap_mi('<leader>ll',
--     function() vim.cmd("bnext" .. vim.v.count1) end, '[<leader>ll] Jump to Next Buffer')
nmap_mi('<S-F7>', ':%s/\\s\\+$//g<CR>', '[<S-F7>] Remove Trailing Whitespace From Lines')

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- Hook into search/jump keymaps to make them a little bit more magical
vim.keymap.set('n', 'n', "nzz", { noremap = true, silent = true })
vim.keymap.set('n', 'N', "Nzz", { noremap = true, silent = true })
vim.keymap.set('n', '*', "*zz", { noremap = true, silent = true })
vim.keymap.set('n', '#', "#zz", { noremap = true, silent = true })
vim.keymap.set('n', 'g*', "g*zz", { noremap = true, silent = true })
vim.keymap.set('n', '/', "/\\v", { noremap = true, silent = false })

--============================================================================
-- LSP KEYMAPS
--============================================================================

-- This function gets run when an LSP connects to a particular buffer.
keymap.on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]et [R]eferences')
    nmap('<leader>si', require('telescope.builtin').lsp_implementations,'[S]earch for [I]mplementations')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    nmap('<leader>e', vim.diagnostic.open_float, '')
    nmap('[d', vim.diagnostic.goto_prev, '')
    nmap(']d', vim.diagnostic.goto_next, '')
    nmap('<leader>ql', vim.diagnostic.setloclist, '')
    nmap('<leader>f',
        function() vim.lsp.buf.format({ async = true }) end, 'Format current buffer with LSP' )

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

-- local on_attach = function(_, bufnr)
--
--     local opts = { buffer = bufnr }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wl', function()
--         vim.inspect(vim.lsp.buf.list_workspace_folders())
--     end, opts)
--     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', '<leader>sl',
--         require('telescope.builtin').lsp_document_symbols, opts)
--
-- end
return keymap
