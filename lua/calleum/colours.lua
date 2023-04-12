-- Set the colorscheme and customisations for each.
-- vim.cmd [[colorscheme gruvbox-flat]]
-- vim.cmd('colorscheme solarized')
-- vim.cmd('colorscheme dracula')
-- vim.cmd 'colorscheme material'
require("tokyonight").setup({
  on_colors = function(colors)
    colors.fg = "#fffff5"
  end
})
vim.cmd 'colorscheme tokyonight-storm'
vim.g.material_style = "palenight"
