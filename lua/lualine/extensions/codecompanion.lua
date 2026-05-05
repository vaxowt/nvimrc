-- lualine extension for codecompanion.nvim

local M = {}

M.sections = {
    lualine_a = {
        {
            'mode',
            fmt = function(str)
                return str:sub(1, 1)
            end,
        },
    },
    lualine_b = {},

    lualine_c = { 'filename' },
    lualine_x = {
        'encoding',
        'fileformat',
        { 'codecompanion', show_adapter = true, show_model = true },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
}

M.inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'codecompanion' },
    lualine_y = {},
    lualine_z = {},
}

M.filetypes = { 'codecompanion' }

return M
