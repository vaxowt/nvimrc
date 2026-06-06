return {
    -- A highly customizable theme for vim and neovim with support for lsp,
    -- treesitter and a variety of plugins.
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

    -- Soothing pastel theme for Neovim.
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
    },

    -- Material colorscheme for NeoVim written in Lua with built-in support
    -- for native LSP, TreeSitter and many more plugins.
    {
        'marko-cerovac/material.nvim',
        lazy = true,
    },

    -- GitHub's Neovim themes.
    {
        'projekt0n/github-nvim-theme',
        lazy = true,
    },

    -- Atom's iconic One Dark theme for Neovim, written in Lua.
    { 'ful1e5/onedark.nvim', lazy = true },

    -- Gruvbox with Material Palette
    {
        'sainnhe/gruvbox-material',
        lazy = true,
        -- load config first
        init = function()
            vim.g.gruvbox_material_sign_column_background = 'none'
            vim.g.gruvbox_material_better_performance = 1
        end,
    },

    -- Comfortable & Pleasant Color Scheme for Vim
    {
        'sainnhe/everforest',
        init = function()
            vim.g.everforest_sign_column_background = 'none'
            vim.g.everforest_better_performance = 1
            vim.g.everforest_enable_italic = 1
            -- vim.g.everforest_float_style = 'none'
        end,
    },

    -- {
    --     'neanias/everforest-nvim',
    --     version = false,
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     main = 'everforest',
    --     -- Optional; default configuration will be used if setup isn't called.
    --     opts = {
    --         italicc = true,
    --     },
    -- },

    -- Clean & Elegant Color Scheme inspired by Atom One and Material.
    {
        'sainnhe/edge',
        init = function()
            vim.g.edge_sign_column_background = 'none'
            vim.g.edge_better_performance = 1
        end,
    },

    -- An arctic, north-bluish clean and elegant Vim theme
    {
        'shaunsingh/nord.nvim',
    },
}
