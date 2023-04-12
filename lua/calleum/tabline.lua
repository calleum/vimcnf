-- lualine config
require 'lualine'.setup {
    options = { theme = 'gruvbox' },
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    sections = {
        lualine_c = { { 'filename', path = 1, } },
    },
    extensions = { 'fugitive', 'nvim-dap-ui' }
}
