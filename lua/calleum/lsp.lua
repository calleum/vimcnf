-- LSP settings
local lsp = {}

local lspconfig = require 'lspconfig'

-- nvim-cmp supports additional completion capabilities
lsp.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.on_attach = require('calleum.keymap').on_attach

-- Enable the following language servers
local servers = {
    'clangd', 'bashls', 'texlab', 'gopls',
    'dockerls', 'tsserver', 'racket_langserver'
}

for _, lsp_conf in ipairs(servers) do
    lspconfig[lsp_conf].setup { on_attach = lsp.on_attach, capabilities = lsp.capabilities }
end

-- nvim-cmp setup

return lsp
