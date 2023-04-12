local luasnip = require 'luasnip'

local cmp = require 'cmp'
cmp.setup {
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping.confirm { select = false },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    }),
    sources = {
        { name = 'nvim_lsp'},
        { name = 'nvim_lsp_signature_help', max_item_count = 4, keyword_length = 3 },
        { name = 'nvim_lua', max_item_count = 4, keyword_length = 3 },
        { name = 'luasnip', max_item_count = 4, keyword_length = 3 },
        { name = 'buffer', max_item_count = 2, keyword_length = 5 },
        { name = 'path', keyword_length = 3 },
        { name = 'calc'},
    }
}

-- luasnip setup
require("luasnip.loaders.from_lua").load({ paths = "./snippets" })
require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })
require("luasnip.loaders.from_vscode").lazy_load()

