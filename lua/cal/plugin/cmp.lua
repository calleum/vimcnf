-- [nfnl] fnl/cal/plugin/cmp.fnl
local uu = require("cal.util")
local function _1_()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  luasnip.config.setup({})
  local function _2_()
    if luasnip.locally_jumpable(( - 1)) then
      return luasnip.jump(( - 1))
    else
      return nil
    end
  end
  local function _4_()
    if luasnip.expand_or_locally_jumpable() then
      return luasnip.expand_or_jump()
    else
      return nil
    end
  end
  local function _6_(args)
    return luasnip.lsp_expand(args.body)
  end
  return cmp.setup({completion = {completeopt = "menu,menuone,noinsert"}, mapping = cmp.mapping.preset.insert({["<C-Space>"] = cmp.mapping.complete({}), ["<C-b>"] = cmp.mapping.scroll_docs(( - 4)), ["<C-f>"] = cmp.mapping.scroll_docs(4), ["<C-h>"] = cmp.mapping(_2_, {"i", "s"}), ["<C-l>"] = cmp.mapping(_4_, {"i", "s"}), ["<C-n>"] = cmp.mapping.select_next_item(), ["<C-p>"] = cmp.mapping.select_prev_item(), ["<CR>"] = cmp.mapping.confirm({select = true}), ["<C-y>"] = cmp.mapping.confirm({select = true})}), snippet = {expand = _6_}, sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}}})
end
local function _7_()
  if ((vim.fn.has("win32") == 1) or (vim.fn.executable("make") == 0)) then
    return 
  else
  end
  return "make install_jsregexp"
end
local function _9_()
  require("luasnip.loaders.from_lua").load({paths = "./snippets"})
  require("luasnip.loaders.from_vscode").load({paths = "./snippets"})
  return require("luasnip.loaders.from_vscode").lazy_load()
end
return {"hrsh7th/nvim-cmp", config = _1_, dependencies = {{"L3MON4D3/LuaSnip", build = _7_(), dependencies = {uu.tx("rafamadriz/friendly-snippets", {config = _9_})}}, "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path"}, event = "InsertEnter"}
