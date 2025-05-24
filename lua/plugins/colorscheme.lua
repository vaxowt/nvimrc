return {
    {
        'EdenEast/nightfox.nvim',
        lazy = true,
        opts = {
            options = {
                styles = {
                    comments = 'italic',
                },
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
    },
    {
        'marko-cerovac/material.nvim',
        lazy = true,
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = true,
    },
    { 'ful1e5/onedark.nvim' },
    -- Gruvbox with Material Palette
    {
        'sainnhe/gruvbox-material',
        lazy = true,
        -- load config first
        config = function()
            vim.g.gruvbox_material_sign_column_background = 'none'
            vim.g.gruvbox_material_better_performance = 1
        end,
    },
    -- Comfortable & Pleasant Color Scheme for Vim
    -- {
    --     'sainnhe/everforest',
    --     lazy = false,
    --     config = get_config('everforest'),
    -- },
    {
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        main = 'everforest',
        -- Optional; default configuration will be used if setup isn't called.
        opts = {
            italicc = true,
        },
    },
    {
        'sainnhe/edge',
        lazy = false,
        config = function()
            vim.g.edge_sign_column_background = 'none'
            vim.g.edge_better_performance = 1
        end,
    },
    -- An arctic, north-bluish clean and elegant Vim theme
    {
        'shaunsingh/nord.nvim',
        lazy = false,
    },
}
